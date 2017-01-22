---
title: "Deploy and Host a Ruby App Running Non-Web Processes"
redirect_from: "/blog/deploy-non-web-ruby-app/"
tags: ruby dev-ops
excerpt: "Most ruby apps use web frameworks such as Rails or Sinatra, and thus are deployed and hosted to run web servers. I recently had the need to host something out of the norm: a plain-old ruby app running non-web processes. I did it using capistrano, foreman, upstart, and monit. Here's how."
---

Most ruby apps use web frameworks such as Rails
or Sinatra, and thus are deployed and hosted to run web
processes: servers like unicorn, puma, or thin.

I recently had the need to host something out of the norm:
a plain-old ruby app
(i.e. a non-Rails, non-Sinatra app) running only non-web processes.
Since this is something I had never done before, and
something I hadn't read about other people doing, I thought it might be
useful to record what I did.

### Background

The app has a `Procfile` sitting in its root that declares the two
commands that must run for the app to carry out its functions:

{% highlight bash %}
# ./Procfile
shoryuken: bundle exec shoryuken -C config/shoryuken.yml
clockwork: bundle exec clockwork bin/clockwork.rb
{% endhighlight %}

[This](https://devcenter.heroku.com/articles/process-model) is a useful
article explaining the process model that the `Procfile` presupposes.
And here's some information about
[shoryuken](https://github.com/phstc/shoryuken) and
[clockwork](https://github.com/tomykaira/clockwork).

The app is run in development using
[foreman](https://github.com/ddollar/foreman), which coordinates the start
of both processes at once with `bundle exec foreman start`.
This isn't strictly necessary.
The processes could always be started manually simply by running the commands in
the `Procfile`. But it is convenient.

What's more than convenient, however, is foreman's ability to "export", or
translate, a `Procfile` into [init](https://en.wikipedia.org/wiki/Init)
files on a server so that the
processes turn on when your server boots up, and (most importantly) can be
managed and monitored like other system services. Since it's really important
that this app run with no down-time in production, this will be very useful.

Instead of init, I'll be using [upstart](http://upstart.ubuntu.com/) in
production. Upstart is an event-based replacement of init that ships with
most distributions of Linux.
[This](https://en.wikipedia.org/wiki/Upstart#Rationale) offers a good
description of the differences between the two, and the benefits of Upstart.
Because I'll be using Upstart, I'm going to need to have foreman export my
`Procfile` in the format expected by Upstart.

Once the processes have been written as init files on the production server,
and can be run like system services,
I'll use [monit](https://bitbucket.org/tildeslash/monit)
to monitor these services to make sure
that they stay up, and restart them if they go down.

Finally, I'm going to deploy the whole thing with capistrano.

### Launch your EC2 Instance

Launch an EC2 server from Amazon running Ubuntu 14.04.
The standard configurations suggested
by Amazon during the launch process are all fine. The only non-standard
thing to do is NOT create a security group for port 80 (for HTTP
connections). There's no need to open port 80 since this isn't
a web server. Also, make sure that the instance permits traffic
on port 22 to allow SSH access -- though, 22 should be open by default.

Once the EC2 instance is launched, download your `.pem` file and
write down its public IP address.

### Get SSH Access to your EC2 Instance

SSH into your server for the first time:

{% highlight bash %}
mv ~/Downloads/my_app.pem ./
sudo chmod 600 my_app.pem
ssh -2 -i my_app.pem ubuntu@YOUR_IP
{% endhighlight %}

Add your public key to the server:

{% highlight bash %}
vim ~/.ssh/authorized_keys
{% endhighlight %}

Now you'll be able to SSH in the server the
normal way, i.e. with `ssh ubuntu@YOUR_IP`.

### Server Setup

Prepare for provisioning:

{% highlight bash %}
sudo apt-get update
sudo apt-get upgrade
{% endhighlight %}

Install command line tools:

{% highlight bash %}
sudo apt-get install \
  mc \
  silversearcher-ag \
  htop \
  curl \
{% endhighlight %}

If you're getting "can't resolve host ip-..." warnings, you can
get rid of them by doing the
[following](https://forums.aws.amazon.com/message.jspa?messageID=495274):
{% highlight bash %}
sudo echo "127.0.1.1 ip-<the_ip_after_ubuntu@_when_you_ssh_in>" >> /etc/hosts
{% endhighlight %}

Install system packages: (you may need to get rid of the line breaks)

{% highlight bash %}
sudo apt-get install \
  git-core \
  build-essential \
  bison \
  openssl \
  libreadline6 \
  libreadline6-dev \
  libffi-dev \
  zlib1g \
  zlib1g-dev \
  libssl-dev \
  libpam0g-dev \
  libyaml-dev \
  libxml2-dev \
  libxslt-dev \
  autoconf \
  libc6-dev \
  ncurses-dev \
  libcurl4-openssl-dev \
  python-software-properties \
  upstart \
  monit \
{% endhighlight %}

Install ruby via rbenv:
{% highlight bash %}
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
rbenv install 2.0.0-p647
rbenv global 2.0.0-p647
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler # v 1.10.6

# this is needed to use foreman export with capistrano
git clone git://github.com/dcarley/rbenv-sudo.git ~/.rbenv/plugins/rbenv-sudo
{% endhighlight %}

Configure SSH access to Github:
{% highlight bash %}
ssh-keygen -t rsa -C my_app@my_ec2
# add your /home/ubuntu/.ssh/id_rsa.pub to github via their GUI
ssh -T git@github.com
{% endhighlight %}

Set up a directory for the app on the server:
{% highlight bash %}
sudo mkdir /data
sudo chown -R ubuntu:ubuntu /data
{% endhighlight %}

__Set up Monit__

We're going to write a deploy script that invokes monit to
make sure that the
processes are running and start them if they aren't. So it's really
important to get monit set up correctly.

To do that, you'll need to actually tell monit what it's supposed to
keep running. To do that, copy the following into
`/etc/monit/monitrc` on the server:

{% highlight bash %}
# /etc/monit/monitrc

set httpd port 2812 and
   use address localhost  # only accept connection from localhost
   allow localhost        # allow localhost to connect to the server

set daemon 120            # check services in 2 minute intervals

check process shoryuken matching 'bin/shoryuken'
  group my_app            # this group name will be used by capistrano
  start program "/sbin/start shoryuken"
  stop program "/sbin/stop shoryuken"

check process clockwork matching 'bin/clockwork'
  group my_app            # this group name will be used by capistrano
  start program "/sbin/start clockwork"
  stop program "/sbin/stop clockwork"
{% endhighlight %}

Now set the permissions on the `monitrc` file:
{% highlight bash %}
sudo chmod 0700 /etc/monit/monitrc
sudo chown -R root:root /etc/monit/monitrc
{% endhighlight %}

__Set up Capistrano Deployment__

We're going to deploy the app with capistrano.
First, add the gem to your Gemfile:

{% highlight ruby %}
# ./Gemfile

group :development do
  gem 'capistrano', '3.4.0'
  gem 'capistrano-rbenv', '2.0.3'
end
{% endhighlight %}

Then create your `Capfile`:

{% highlight ruby %}
# ./Capfile

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rbenv'
{% endhighlight %}

Then create your `deploy.rb`:

{% highlight ruby %}
# ./config/deploy.rb

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

set :application, 'my_app'
set :repo_url, "git@github.com:my_username/#{ fetch :application }.git"

set :stages, ["production"]
set :default_stage, "production"
set :deploy_via,  :remote_cache

after "deploy:restart", "deploy:cleanup"

set :deploy_to, "/data/#{fetch :application}"
set :scm, :git

set :format, :pretty
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# the application doesn't have front_end assets to sync
set :normalize_asset_timestamps, false

set :keep_releases, 5

namespace :deploy do
  desc 'Override the default migration behavior'
  task :migrate do
    puts "No migrations to run!"
  end
end

namespace :foreman do
  # https://github.com/ddollar/foreman/wiki/Exporting-for-production#production-environment
  desc "Sym-link the shared .env file for export to Ubuntu"
  task :export_env do
    on roles(:app) do
      execute :ln, '-nfs', "#{shared_path}/.env", "#{release_path}/.env"
    end
  end

  # https://gist.github.com/carlo/1027117#gistcomment-1415398
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export_procs do
    on roles(:app) do
      within current_path do
        execute :rbenv, :exec, "bundle install"
        execute :rbenv, :sudo, "bundle exec foreman export upstart /etc/init --procfile=./Procfile -a #{fetch(:application)} -u #{fetch(:user)} -l #{current_path}/log"
      end
    end
  end
end

after "deploy:publishing", "foreman:export_env"
after "deploy:publishing", "foreman:export_procs"
{% endhighlight %}

Finally, your production-specific deployment script:

{% highlight ruby %}
set :os, 'ubuntu'
set :user, 'ubuntu'
role :app, '<YOUR IP HERE>'

server '<YOUR IP HERE>', roles: [:app], user: 'ubuntu'

set :branch,    'master'
set :stage,     :production
set :rails_env, :production

namespace :monit do
  desc "Restart the application services using monit"
  task :restart do
    on roles(:app) do
      execute :sudo, 'service monit start'
      execute :sudo, 'monit -c /etc/monit/monitrc -g my_app restart'
    end
  end
end

after 'deploy:publishing', 'monit:restart'
{% endhighlight %}

At this point, just `bundle install` and try to deploy!
Capistrano is already configured to set up a
bunch of folders and files for you that the rest of this setup script
presupposes. Note that you will need to update the IP address in the
`config/deploy/production.rb` script.
Also note that at this point the deploy will fail. That's okay!

Though the deployment failed, it should have succeeded in
translating your Procfile into init files. To check this:

{% highlight bash %}
ls -l /etc/init my_app*
{% endhighlight %}

You should see something like the following:

{% highlight bash %}
-rw-r--r-- 1 root root   50 Dec  4 14:55 my_app.conf
-rw-r--r-- 1 root root 1329 Dec  4 14:55 my_app-clockwork-1.conf
-rw-r--r-- 1 root root   49 Dec  4 14:55 my_app-clockwork.conf
-rw-r--r-- 1 root root 1355 Dec  4 14:55 my_app-shoryuken-1.conf
-rw-r--r-- 1 root root   49 Dec  4 14:55 my_app-shoryuken.conf
{% endhighlight %}

If you don't, then capistrano probably failed before foreman
was able to export the Procfile. To debug this, simply cd into the
`/data/my_app/current` folder and attempt to run the `bundle exec
foreman export upstart` command in the `deploy.rb` script above.

Let's `cat my_app-shoryuken-1.conf` to see what's inside:

{% highlight bash %}
start on starting my_app-shoryuken
stop on stopping my_app-shoryuken
respawn

env PORT=5100

setuid ubuntu

chdir /data/my_app/releases/20151204145532

exec bundle exec shoryuken -C config/shoryuken.yml
{% endhighlight %}

Note that the only environment variable being set in this file is the
PORT. That's important. The shell that Upstart uses to run your commands
won't contain any of the environment variables in the shell that you're
currently working with on the server. So, if your app needs ENV vars to run
its processes (as it likely does), then you'll need to get these variables
in the Upstart shell. It won't be good enough to simply `export` them into
your current shell.

Fortunately, foreman will take care of this for you if you just put the needed
ENV vars in a `.env` file sitting in your application's root. Now, you obviously
don't want to check your `.env` file into version control. But
capistrano only deploys the files that have been checked into version control.
So, it seems that you might have a problem getting your `.env` file on the server
during deployment.

This problem has an easy solution.
The deploy script is currently set up to sym-link
`/data/my_app/shared/.env` into `/data/my_app/current/.env` before
translating your Procfile to init files. So, all you need to do is this:

{% highlight bash %}
touch /data/my_app/shared/.env
vim /data/my_app/shared/.env
# add your ENV variables to this file
# just use the syntax VARIABLE='xxxxxxxxx'
# don't use `export`s
{% endhighlight %}

Now when you deploy foreman will automatically write the ENV vars into
the init files for your processes so that they'll be in the upstart shell
that runs your commands.

The server should now be ready to go. To confirm, deploy the
app again with `bundle exec cap production deploy`. It should
exit without a failure code.

SSH into the server to take a look at your new init files. They should
look the same as they did before, but now they should contain all of the
ENV variables that you placed in your `.env` file.

Also take a look at the running processes on the server.
You should see something like the following:
{% highlight bash %}
ps aux | ag 'shoryuken|clockwork'
# ubuntu   10804 42.0  2.3 1261504 95224 ? Ssl  20:14   0:02 ruby /home/ubuntu/.rbenv/versions/2.0.0-p647/lib/ruby/gems/2.0.0/bin/shoryuken -C config/shoryuken.yml
# ubuntu    3383  0.0  2.1 253056 88268 ?  Ssl  19:45   0:02 ruby /home/ubuntu/.rbenv/versions/2.0.0-p647/bin/clockwork bin/clockwork.rb
{% endhighlight %}

Great! Both processes are up and running.

You should also be able to see each process writing its output to the logs with
`tail -f /data/my_app/current/log/*`. Note that clockwork is a slow-running
process, so it takes a few seconds to write each line. Also bear in mind that
shoryuken throws a lot of information into the logs. But if you can see both
processes writing to the logs, then you know the app is up and running.

And that's it! We've now deployed a plain-old ruby app to a production
environment and set it up to run two non-web processes.

## Helpful Hints

### Check Services Running on the Server

The three most important services on the server are:

  * monit
  * my_app-shoryuken
  * my_app-clockwork

To check the status of a service, any of these commands will work:
{% highlight bash %}
sudo status <name>
sudo service <name> status
sudo sbin/status <name>
{% endhighlight %}

To start a service, just replace `status` with `start` in the above commands. To
stop a service, just replace `status` with `stop`. To restart, replace with
`restart`. You get the idea. Note that you won't be able to stop shoryuken or
clockwork without first stopping monit, since monit is set up to restart these
services whenever they go down.

### Deploy with Capistrano
{% highlight bash %}
bundle exec cap production deploy
{% endhighlight %}

### Troubleshooting Upstart

Sometimes upstart processes fail to boot up. They will appear to start
when you call them with `sudo service my_app-shoryuken start`, but you won't
be able to see them in the process list on the machine. That's because
there has been an error. To troubleshoot the error, you'll probably need to
dig into the upstart logs. You can view them from `/var/logs/upstart`.
There's a single log for each separate service, making it easy to troubleshoot.
Typically the problem has to do with missing environment variables.

You may have to manually restart the application
services on the server in order to have the upstart logs show up for them while
debugging, i.e.:
{% highlight bash %}
sudo service my_app-shoryuken stop
sudo service my_app-shoryuken start
{% endhighlight %}
You should now see a `my_app-shoryuken-xxx.log` in `/var/log/upstart` if upstart
is having trouble running your commands.

If the services don't seem to be starting, but there is nothing being written to the
upstart logs, that suggests that there were no system-level errors when starting
the services. You might, instead, be dealing with runtime errors.
The place to look for these is the logs in the
application directory: `/data/my_app/current/log/`.

### Helpful References:
  * crmaxx's [gist](https://gist.github.com/crmaxx/4598302)
  * Denis Suratna's [blog post](http://dennissuratna.com/rails-deployment-aws2/)
  * carlo's [gist](https://gist.github.com/carlo/1027117)
  * this medium [post](https://medium.com/@rdsubhas/ruby-in-production-lessons-learned-36d7ab726d99#.b1elnlq9w)
  * the [gorails](https://gorails.com/setup/ubuntu/14.04) install guide
