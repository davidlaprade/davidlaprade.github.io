# Provision EC2 for a Ruby App Running Non-Web Processes

Most ruby apps that you read about are using web frameworks such as Rails
or Sinatra. And, as such, most ruby apps are deployed and hosted to run web
processes -- servers like unicorn, puma, or thin.

I recently had the need to host something out of the norm: a plain-old ruby app
(i.e. non-Rails, non-Sinatra) running two non-web processes.
Since this is something I had never done before, and
something I hadn't read about other people doing, I thought it might be
useful to describe the steps that I took here.

I did it using upstart, monit, capistrano, and foreman on an AWS EC2 instance.

And, in the interest of avoiding jargon, "provision" just means "install
programs".

### Launch your EC2 Instance

This post presupposes that:
* your instance is running Ubuntu 14.04
* your instance allows access to port 22 (for SSH) but not port 80 (for HTTP)
* you've downloaded your `.pem` file
* you've got your public IP

### Get SSH Access to your EC2 Instance

```bash
mv ~/Downloads/my_app.pem ./
sudo chmod 600 my_app.pem
ssh -2 -i my_app.pem ubuntu@YOUR_IP
vim ~/.ssh/authorized_keys # add your id_rsa.pub
```

With your public key added to the server, you'll now be able to SSH in the
normal way, i.e. with `ssh ubuntu@YOUR_IP`.

Prepare for provisioning:

```bash
sudo apt-get update
sudo apt-get upgrade
```

Install command line tools:

```bash
sudo apt-get install \
  mc \
  silversearcher-ag \
  htop \
  curl \
```

If you're getting "can't resolve host ip-..." warnings, you can
get rid of them by doing the [following](https://forums.aws.amazon.com/message.jspa?messageID=495274):
``` bash
sudo vim /etc/hosts
# then add "127.0.1.1 ip-<the_ip_after_ubuntu@_when_you_ssh_in"
```

Install system packages: (you may need to get rid of the line breaks)

```bash
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
```

Install ruby via rbenv:
```bash
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
```

Configure SSH access to Github:
```bash
ssh-keygen -t rsa -C my_app@my_ec2
# add your /home/ubuntu/.ssh/id_rsa.pub to github via their GUI
ssh -T git@github.com
```

Set up a directory for the app on the server:
```bash
sudo mkdir /data
sudo chown -R ubuntu:ubuntu /data
```

__Set up Monit__

Basically we're going to write a deploy script that envokes monit to
make sure that the
processes are running and start them if they aren't. So it's really
important to get monit set up correctly.

To do that, you'll need to actually tell monit what it is supposed to
keep running. To do that, copy the following into
`/etc/monit/monitrc` on the server and set up its permissions:

```bash
set httpd port 2812 and
   use address localhost  # only accept connection from localhost
   allow localhost        # allow localhost to connect to the server

set daemon 120               # check services in 2 minute intervals

check process shoryuken matching 'bin/shoryuken'
  group my_app
  start program "/sbin/start shoryuken"
  stop program "/sbin/stop shoryuken"

check process scheduler matching 'bin/scheduler'
  group my_app
  start program "/sbin/start scheduler"
  stop program "/sbin/stop scheduler"
```

Now set the permissions on the `monitrc` file:
```bash
sudo chmod 0700 /etc/monit/monitrc
sudo chown -R root:root /etc/monit/monitrc
```

__Set up Capistrano Deployment__

We're going to deploy the app with capistrano.
First, add the gem to your Gemfile:

```ruby
# ./Gemfile

group :development do
  gem 'capistrano', '3.4.0'
  gem 'capistrano-rbenv', '2.0.3'
end
```

Then create your `Capfile`:

```ruby
# ./Capfile

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rbenv'
# set production as the default deployment
# http://stackoverflow.com/questions/21006875/set-default-stage-with-capistrano-3
invoke :production
```

Then create your `deploy.rb`:

```ruby
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
```

Finally, your production-specific deployment script:

```ruby
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
```

At this point, just `bundle install` and try to deploy!
Capistrano is already configured to set up a
bunch of folders and files for you that the rest of this setup script
presupposes. Note that you will need to update the IP address in the
`config/deploy/production.rb` script if you just created a fresh machine.
Also note that at this point the deploy will fail. That's okay!

After attempting to deploy, you'll want to create a .env file on the
server for foreman to read your environment variables from
and inject them into the shell that will run your application
services. The deploy script is currently set up to sym-link
`/data/my_app/shared/.env` into `/data/my_app/current/.env` after the
application has been deployed. So, all you need to do is this:

```bash
touch /data/my_app/shared/.env
vim /data/my_app/shared/.env
# don't use exports, just use the syntax VARIABLE='xxxxxxxxx'
# see the `my_app.env.sh` file in the Rails Setup folder on the google drive
```

Now you'll need to export your variables into your shell's environment
so that you can run the bootstrap script which will create the SQS
queues for you and configure their permissions. To do this, just go into the
Rails Setup folder, grab all of the production variables from `my_app.env.sh`,
add an `export` to the front, then copy and paste into the terminal like so:

```bash
export AWS_ACCESS_KEY='xxxxxxxx'
export AWS_SECRET_KEY='xxxxxxxx'
# and so on ...
```

Run the setup script:

```bash
cd /data/my_app/current && bin/bootstrap
```

At this point you may have to manually turn off and then on the application
services on the server in order to have the upstart logs show up for them while
debugging (see below for more info on debugging Upstart). Here's how:
```bash
sudo service my_app-shoryuken stop
sudo service my_app-shoryuken start
```
You should now see a `my_app-shoryuken-xxx.log` in `/var/log/upstart` if upstart
is having trouble running your commands as system services.


__Now let's get redis set up!__

You'll need an AWS ElastiCache running redis for
this part.
[Here](https://github.com/ascensionpress/ascensionpress/issues/1078#issuecomment-160756751)
are the steps I took. I basically just followed
[these](https://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/GettingStarted.html)
AWS instructions.
[This](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-redis)
digital ocean article was also helpful.

Once you've got your ElasticCache setup through the AWS GUI, here's how you give
your EC2 instance access to it. First SSH into the server, then:

```bash
cd
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
make test
src/redis-cli -h my_app.otvqge.0001.use1.cache.amazonaws.com -p 6379
```

You'll know you've succeeded if a redis console opens up. Be sure to update your
`.env` file with the redis URI from above.

Congrats! The server should now be ready to go. To confirm, deploy the
app again with `bundle exec cap deploy`. Then SSH into the server at look at the
running processes. You should see something like the following:
```bash
ps aux | ag shoryuken
# ubuntu   10804 42.0  2.3 1261504 95224 ?       Ssl  20:14   0:02 ruby /home/ubuntu/.rbenv/versions/2.0.0-p647/lib/ruby/gems/2.0.0/bin/shoryuken -C config/shoryuken.yml -r ./lib/my_app.rb
ps aux | ag scheduler
# ubuntu    3383  0.0  2.1 253056 88268 ?        Ssl  19:45   0:02 ruby
/home/ubuntu/.rbenv/versions/2.0.0-p647/bin/clockwork bin/scheduler.rb
```
And you should be able to see each writing their output to their logs with
`tail -f /data/my_app/current/log/*`. Note that scheduler takes a couple minutes
to show up sometimes.


# Helpful Hints

### Check Services Running on the Server

There are three services you need to know about on the server:
  * monit
  * my_app-shoryuken
  * my_app-scheduler

To check the status of a service, any of these commands will work:
```bash
sudo status <name>
sudo service <name> status
sudo sbin/status <name>
```

To start a service, just replace `status` with `start` in the above commands. To
stop a service, just replace `status` with `stop`. To restart, replace with
`restart`. You get the idea. Note that you won't be able to stop shoryuken or
scheduler without first stopping monit, since monit is set up to restart these
services whenever they go down.

If shoryuken or scheduler doesn't appear to be working, you'll probably want to
look at the upstart logs. Go to `/var/log/upstart/` and tail the log for the
service that you're worried about:

```bash
sudo tail -f /var/log/upstart/my_app-shoryuken-1.log
```

Or, inspect the service files that were generated by foreman during deployment:

```bash
cd /etc/init
sudo vim my_app-shoryuken-1.conf
```

### Deploy with [Capistrano](https://github.com/capistrano/capistrano):
```bash
bundle exec cap deploy
```

### Troubleshooting Upstart

Sometimes upstart processes fail to boot up. They will appear to start
when you call them with `sudo service my_app-shoryuken start`, but you won't
be able to see them in the process list on the machine. That's because
there has been an error. To troubleshoot the error, you'll probably need to
dig into the upstart logs. You can view them from `/var/logs/upstart`.
There's a single log for each separate service, making it easy to troubleshoot.

Typically the problem has to do with missing environment variables. In order to
give the processes managed by upstart access to your environment variables, you
need to put those variables in a `.env` file in the project's root on the
server. Foreman will read these variables and embed them into the `/etc/init`
files that it creates for upstart. The way this is currently handled is that there
is a `.env` file in `/data/my_app/shared` which is sym-linked into the directory
of the current build on each deploy. After sym-linking, capistrano executes the
foreman export script to write the process files into `/etc/init`. So, if you
ever need to tweak the `.env` files, you should change them in
`/data/my_app/shared/.env` and then redeploy.

### Environment Variables

* officially they live in `/data/my_app/shared/.env` -- these are the variables
  that are pulled into the services by foreman
* however, to run the bootstrap script you'll need to get the variables in your
  shell's environment. To do that, just manually add an `export` to the front of
  each variable in `/data/my_app/shared/.env`, then run it in the shell. Then you
  should be able to run `bin/bootstrap` from within my_app and have it create the
  SQS queues for you in production

### Helpful references:
  * crmaxx's [gist](https://gist.github.com/crmaxx/4598302)
  * Denis Suratna's [blog post](http://dennissuratna.com/rails-deployment-aws2/)
  * carlo's [gist](https://gist.github.com/carlo/1027117)
  * this medium [post](https://medium.com/@rdsubhas/ruby-in-production-lessons-learned-36d7ab726d99#.b1elnlq9w)
  * the [gorails](https://gorails.com/setup/ubuntu/14.04) install guide

