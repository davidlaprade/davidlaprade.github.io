---
title: "Speed Up Rails Tests"
excerpt: "I recently cut the run time of a legacy Rails app by 32 min on CI, and 21 min locally. Here are the changes that made the biggest difference."
---

There are a lot of suggestions as to how to speed up a test suite.
But many of them don't make much of a difference.
The following are the changes that I found most useful when attempting to
speed up the test suite for a legacy Rails app, along with the amount of time
each saved. In brief, they were:

* Record/Stub All API Calls (saved ~10 min)
* Decrease Ruby's Garbage Collection Frequency (saved ~8 min)
* Clean the DB With Transactions (saved ~5 min)
* Profile the Test Suite After Each Run (saved ~4 min)
* Block requests to external URLs (saved ~4 min)

### Background

As a caveat, these changes worked for me because of the
particular details of the app I was working on. Obviously, every app
is different. So, I figured it might be useful to give a little more detail
about the app in question.

The `Gemfile`:

{% highlight ruby %}
gem 'rails',                  '3.2.16'

group :test do
  gem 'capybara',             '2.4.4'
  gem 'capybara-screenshot',  '1.0.4'
  gem "selenium-webdriver",   '2.45.0'
  gem "capybara-webkit",      '1.6.0'
  gem "formulaic",            '0.1.3'
  gem 'factory_girl',         '3.5.0'
  gem 'rspec-rails',          '2.14.0'
  gem 'rspec-instafail',      '0.4.0'
  gem 'ffaker',               '1.15.0'
  gem 'shoulda-matchers',     '2.6.1'
end
{% endhighlight %}

The `spec_helper.rb`:

{% highlight ruby %}

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'rspec/instafail'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara-screenshot/rspec'

# Require support files in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Require factories in spec/factories
Dir[File.join(File.dirname(__FILE__), "factories/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, :type => :controller
  config.include Formulaic::Dsl
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

Devise.stretches = 1

{% endhighlight %}

The directory structure:

{% highlight bash %}
$ tree spec
spec
├── features
├── controllers
├── lib
├── models
├── factories
├── support
│   └── capybara.rb
│   └── ssl_required.rb
│   └── . . .
└── spec_helper.rb

{% endhighlight %}

The `support` folder will come up a bunch later.

### Record/Stub All API Calls (saved ~10 min)

The test suite was making live API calls. A lot of them. Often to very slow API's.
\*cough\* NetSuite \*cough\*. There were actually some pretty good reasons why
this had been done. But I decided it should stop.

So, I recorded all of the responses to the API calls with VCR.
This has been written about in a few places. For example:
[here](http://railscasts.com/episodes/291-testing-with-vcr), and
[here](https://robots.thoughtbot.com/how-to-stub-external-services-in-tests).

To do this, I made the following additions. First, to the `Gemfile`:

{% highlight ruby %}
# ./Gemfile
group :test do
  gem 'webmock', require: false
  gem 'vcr', require: false
end
{% endhighlight %}

Then, to my `spec_helper`:

{% highlight ruby %}
# ./spec/spec_helper.rb
require 'webmock/rspec'
require 'vcr'
WebMock.disable_net_connect! allow_localhost: true
{% endhighlight %}

Finally, to a new `vcr.rb` support file:

{% highlight ruby %}
# ./spec/support/vcr.rb
VCR.configure do |c|
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [
      :uri,
    # :body, uncomment if you need fine-grained control of recordings
      :method
    ]
  }
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_hosts ['127.0.0.1', 'localhost']

  # filter out any secret keys in the responses
  ENV.select {|var| var.match Regexp.union %w(SECRET KEY PASSWORD ACCOUNT)}.each_key do |key|
    c.filter_sensitive_data(key) { ENV[key] }
  end
end
{% endhighlight %}

Once I did this, I could add a `vcr: true` tag to any examples that were
making live API calls and have them recorded by VCR. The next time the
calls were made, the recordings would automatically be played back. I then
could commit the recordings and push the whole thing to CI.

This was far and away the single most important change. Not only did it save
more time than any other improvement, but it was also
key in improving the reliability of the test suite, and ensuring that we
got consistent results across the team. This made the test suite something we
could actually trust.

### Decrease Ruby's Garbage Collection Frequency (saved ~8 min)

This has been suggested by many people in many places. For example:
[here](http://collectiveidea.com/blog/archives/2015/02/19/optimizing-rails-for-memory-usage-part-2-tuning-the-gc/),
[here](https://ariejan.net/2011/09/24/rspec-speed-up-by-tweaking-ruby-garbage-collection/),
[here](http://railscasts.com/episodes/413-fast-tests), and
[here](https://gist.github.com/burke/1688857).

This change was especially helpful because:

  * The app was running ruby 1.9.3
  * The app had a rather involved CI build. It had extensive seeding and
    configuration scripts. As well as separate databases and test suites
    for each of its 4 engines. This meant, at the very least, that `bundle exec`
    was called no less than 8 times per CI build. (Once to `bundle install`, and
    once to `bundle exec rspec`, for each engine.)

Reducing the CI build complexity helped with some of the problems I was facing.
But even without doing that, speeding up Ruby by modifying its GC (garbage
collection) settings gave the app a huge boost.
This turned out to be very simple to do.
Adding the following variables to our CI
container environment shaved 8 minutes off the build time:

{% highlight bash %}
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_FREE_MIN=500000
export RUBY_HEAP_MIN_SLOTS=40000
{% endhighlight %}

This made ruby eat up much more memory, but dramatically increased speed. Fine
by us, since this was just on CI!
But what about development? Who wants ruby killing their local machine's
RAM just to run a test suite?

Obviously, this wasn't a long-term fix. The change that fixed ruby's GC
permanently was an upgrade to ruby 2.1.6 -- which is dramatically
better about garbage collection than 1.9.3.
In all, then, configuring ruby's GC probably made a huge difference to
the build time on CI, and was the second most important change overall.

### Clean the DB With Transactions (saved ~5 min)

A good deal of time is spent deleting persisted data between examples
in Rspec. Most databases support three different cleanup strategies:

* transaction
* truncation
* deletion

Among these, transactions are considerably faster because they make minimal
changes. They simply reverse the changes made by your tests, nothing more.
Truncation and deletion, by contrast, delete whole tables, or portions of them.
Transactions are also preferable because they are exact. They only reverse what
was changed by the tests. This makes them safe to use when you are seeding
your test database. You don't have to worry about
accidentally deleting important data for the tests with them. Nor do you have
to worry about reseeding between examples. And, since the
application had some pretty substantial seed data to it, this was significant.

There is a problem with truncation, however: it doesn't work when you have
multiple database connections. Each database connection has to have its own
transaction. Why does this matter? Because Capybara (which we use for our
integration tests) starts up a Rails server in a new thread so that the browser
that it runs can access it. And Active Record spawns a new connection to the
database for each thread.

The trick here was to force Capybara to share the same database connection
as the app. There is a well-known
[hack](https://gist.github.com/josevalim/470808)
to do just this. Here's how.

I added the following to the test group in the Gemfile:

{% highlight ruby %}
# ./Gemfile
group :test do
  gem 'database_cleaner',   '1.4.1'
  gem 'connection_pool',    '2.2.0'
end
{% endhighlight %}

Then, I created a new support file for
[database_cleaner](https://github.com/DatabaseCleaner/database_cleaner):

{% highlight ruby %}
# ./spec/support/database_cleaner.rb
require 'database_cleaner'

RSpec.configure do |c|
  c.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  c.after(:each) do
    DatabaseCleaner.clean
  end
end
{% endhighlight %}

Finally, I created a support file for the shared connection code:

{% highlight ruby %}
# ./spec/support/shared_connection.rb
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil
  def self.connection
    @@shared_connection || ConnectionPool::Wrapper.new(:size => 1) { retrieve_connection }
  end
end

ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
{% endhighlight %}

Making this change shaved off close to 5 minutes off the runtime.

### Profile the Test Suite After Each Run (saved ~4 min)

This was suggested [here](http://railscasts.com/episodes/413-fast-tests).
It was very easy to do. I simply added the following to the app's global rspec
config file:

{% highlight bash %}
# ./.rspec
--profile
{% endhighlight %}

This gave me information about the slowest examples and groups at the
end of every successful spec run. For example:

{% highlight bash %}
Top 10 slowest examples (315.41 seconds, 51.0% of total time):
    48.67 seconds ./spec/features/dd/leader_spec.rb:105
    40.72 seconds ./spec/features/review_pack_spec.rb:93
    30.28 seconds ./spec/features/review_pack_spec.rb:109
    30.19 seconds ./spec/features/review_pack_spec.rb:81
    29.84 seconds ./spec/features/checkout/company_spec.rb:23
    29.25 seconds ./spec/features/review_pack_spec.rb:139
    29.19 seconds ./spec/features/checkout/individual_spec.rb:7
    27.53 seconds ./spec/features/review_pack_spec.rb:167
    26.03 seconds ./spec/features/dd/participant_spec.rb:11
    23.72 seconds ./spec/features/dd/leader_program_spec.rb:37
{% endhighlight %}

On its own, this obviously didn't make a difference to the run time.
But what it did do is make it super clear what specs were slowing
down the test suite the most.

This was important because it made me really think twice about whether
some of these legacy tests were worth keeping. As it happened,
some of them were completely useless. Some were testing
functionality that was already tested elsewhere. Others were clicking through
the app without making any concrete expectations at all. And others should
have just been unit tests in the first place. Away they went.

Some of the slow tests, however, were testing crucial features of the app that
it would have been a mistake to ignore. So why were these tests so slow?
To try to find out, I ran the tests using selenium as the javascript driver.
Selenium opens a browser which allows you to actually watch the test suite
click through the app. Fortunately, the app was already set up to
optionally run selenium. Here are the relevant bits of code:

{% highlight ruby %}
firefox_cask_path = '/opt/homebrew-cask/Caskroom/firefox/latest/Firefox.app/Contents/MacOS/firefox-bin'

if File.exists?(firefox_cask_path)
  Selenium::WebDriver::Firefox::Binary.path = firefox_cask_path
end

RSpec.configure do |config|
  config.before(:each, type: :feature) do |s|
    if example.metadata[:selenium].present?
      Capybara.current_driver = :selenium_firefox_driver
    else
      Capybara.current_driver = :webkit_ignore_ssl
    end
  end
end

# Register the selenium firefox driver
Capybara.register_driver :selenium_firefox_driver do |app|
  # http://ihswebdesign.com/knowledge-base/fixing-selenium-timeouterror/
  http_client = Selenium::WebDriver::Remote::Http::Default.new
  http_client.timeout = 200

  profile = Selenium::WebDriver::Firefox::Profile.new

  Capybara::Selenium::Driver.new(
    app,
    :browser     => :firefox,
    :profile     => profile,
    :http_client => http_client
  )
end
{% endhighlight %}

This allowed me to simply add a `selenium: true` tag to the slow
test examples and watch those examples run in a browser.

When I did this, it immediately became clear why they were so slow.
Capybara was taking upwards of 40 seconds to fill in a __single__
select field!

The issue seemed to be caused by
[formulaic](https://github.com/thoughtbot/formulaic), which sells itself as
a convenience DSL (domain specific language) for filling in forms with
Capybara. Formulaic allows you write things like the following in your tests:

{% highlight ruby %}
fill_form(
  :addresses,
  {   order_bill_address_attributes_firstname: 'Frodo',
      order_bill_address_attributes_lastname:  'Baggins',
      order_bill_address_attributes_address1:  '20 Hagerty Blvd',
      order_bill_address_attributes_city:      'The Shire',
      order_bill_address_attributes_state_id:  'Pennsylvania',
      order_bill_address_attributes_zipcode:   '19380',
      order_use_billing:                       true }
)
{% endhighlight %}

Really neat and clean. Unfortunately, it was taking Capybara __forever__
to fill in "Pennsylvania" in the select fields. Once I realized that this was
the problem, it was fairly easy to fix. Just fill in the select fields using
Capybara's form DSL manually, like so:

{% highlight ruby %}
fill_form(
  :addresses,
  {   order_bill_address_attributes_firstname:  'Frodo',
      order_bill_address_attributes_lastname:   'Baggins',
      order_bill_address_attributes_address1:   '20 Hagerty Blvd',
      order_bill_address_attributes_city:       'The Shire',
      # order_bill_address_attributes_state_id: 'Pennsylvania',
      order_bill_address_attributes_zipcode:    '19380',
      order_use_billing:                        true }
)

select 'Pennsylvania', from: 'order_bill_address_attributes_state_id'
{% endhighlight %}

Making these changes saved 4 minutes on the test suite runtime.

I highly recommend profiling your test suite. It's super easy,
and makes it really easy to see trends that might be slowing you down.
Because of it, the current test profile looks like this:

{% highlight bash %}
Top 10 slowest examples (69.61 seconds, 27.2% of total time):
    8.34 seconds ./spec/features/checkout/individual_spec.rb:6
    8.21 seconds ./spec/features/checkout/company_spec.rb:6
    7.57 seconds ./spec/features/product_spec.rb:2
    7.28 seconds ./spec/features/dd/account_spec.rb:109
    7.09 seconds ./spec/lib/dd/merge_manager_spec.rb:124
    6.90 seconds ./spec/lib/dd/merge_manager_spec.rb:38
    6.27 seconds ./spec/features/event_spec.rb:72
    6.11 seconds ./spec/models/dd/taxon_spec.rb:3
    6.02 seconds ./spec/features/dd/participant_spec.rb:9
    5.80 seconds ./spec/features/dd/study_management_spec.rb:52
{% endhighlight %}

That's a big improvement!

### Block requests to external URLs (saved ~4 min)

Thoughtbot had a [blog
post](https://robots.thoughtbot.com/speed-up-javascript-capybara-specs-by-blacklisting-urls)
where they talked about a slow test suite that was caused by
calls to external URLs in feature tests.

Capybara webkit is pretty good about warning you about these kinds of requests
when they are made. And there were a LOT of these warnings when the app's test
suite would run:

{% highlight bash %}
Request to unknown URL:
https://s.ytimg.com/yts/cssbin/www-embed-player-new-vfl1jmrzb.css
To block requests to unknown URLs:
  page.driver.block_unknown_urls
To allow just this URL:
  page.driver.allow_url("https://s.ytimg.com/yts/cssbin/www-embed-player-new-vfl1jmrzb.css")
To allow requests to URLs from this host:
  page.driver.allow_url("s.ytimg.com")
Request to unknown URL: http://fonts.googleapis.com/css?family=Buenard:700,400
To block requests to unknown URLs:
  page.driver.block_unknown_urls
To allow just this URL:
# etc . . .
{% endhighlight %}

I thought that I had blocked all of these URLs with the following code, as per
the capybara webkit
[readme](https://github.com/thoughtbot/capybara-webkit/blob/e9bd20a184d7e3c3b1aeebdceeaa66b2905afca2/README.md#configuration):

{% highlight ruby %}
# ./spec/support/capybara_webkit.rb

Capybara::Webkit.configure do |config|
  config.block_url "*log.olark.com*"
  config.block_url "*content.jwplatform.com*"
  config.block_url "*fonts.googleapis.com*"
  config.block_url "*maxcdn.bootstrapcdn.com*"
  config.block_url "*jwpsrv.com*"
  config.block_url "*static.olark.com*"
  config.block_url "*www.google-analytics.com*"
  config.block_url "*static.intercomcdn.com*"
  config.block_url "*google-analytics.com*"
  config.block_url "*www.youtube.com*"
  config.block_url "*s.ytimg.com*"
  config.block_url "*i.ytimg.com*"
  config.block_url "*netdna.bootstrapcdn.com*"
  config.block_url "*fonts.googleapis.com*"
  config.block_url "*cloudfront.net*"
  config.allow_url "*cdnjs.cloudflare.com/ajax/libs/*"
  config.block_url "*images.mcafeesecure.com*"
  config.block_url "*www.google.com/recaptcha*"
  config.block_url "*www.gstatic.com/recaptcha*"
  config.block_url "*us2.api.mailchimp.com*"
  config.block_url "*mandrillapp.com*"
  config.block_url "*nexus-long-poller-b.intercom.io*"
  config.block_url "*nexus-long-poller-a.intercom.io*"
  config.block_url "*nexus-websocket-b.intercom.io*"
  config.block_url "*insights.hotjar.com*"
  config.block_url "*static.hotjar.com"
  config.block_url "*maps.gstatic.com*"
  config.block_url "*maps.google.com*"
  config.block_url "*mt1.googleapis.com*"
  config.block_url "*mt0.googleapis.com*"
  config.block_url "*maps.googleapis.com*"
end
{% endhighlight %}

The persistence of these warnings, however, and the speed issues I was still
having, lead me to believe that I actually hadn't succeeded in blocking these
requests after all. To try to figure out what was going wrong, I dug into the
[pull request](https://github.com/thoughtbot/capybara-webkit/pull/756/files) that
introduced the global configuration I was attempting to use.

The key to figuring out the issue was in [this
line](https://github.com/thoughtbot/capybara-webkit/pull/756/files#diff-9c845b021068fde9f89989e7d867a6d5R15)
in the pull request:

{% highlight ruby %}
Capybara.register_driver :webkit do |app|
  Capybara::Webkit::Driver.new(
    app,
    Capybara::Webkit::Configuration.to_hash
  )
end
{% endhighlight %}

Pay attention to the `Capybara::Webkit::Configuration.to_hash` call. That is
what pulls all of the URLs out of the configuration block above. Notice that
it has to be manually added as a second parameter
when initializing a new driver. This was significant because the app I was working
on was using a custom webkit driver, and wasn't manually adding in the
configuration:

{% highlight ruby %}
# ./spec/support/capybara.rb
Capybara.register_driver :webkit_ignore_ssl do |app|
  Capybara::Webkit::Driver.new(
    app,
    timeout:              200,
    skip_image_loading:   false,
    ignore_ssl_errors:    true
end
{% endhighlight %}

Having spotted the problem, it was easy to fix. Just add the configuration in!

{% highlight ruby %}
# ./spec/support/capybara.rb
Capybara.register_driver :webkit_ignore_ssl do |app|
  Capybara::Webkit::Driver.new(
    app,
    Capybara::Webkit::Configuration.to_hash.merge(
    timeout:              200,
    skip_image_loading:   false,
    ignore_ssl_errors:    true)
end
{% endhighlight %}

This shaved an additional 4 minutes off of the test run time, and got rid of
a lot of annoying warning messages in the process.

### Conclusion

So, those are the changes that made the biggest difference to the app I was
working on. They were all changes suggested elsewhere by other people. But
hopefully others can benefit from either the implementation detailed here, or
the relative importance suggested by the amount of time they saved me.

Good luck!

-----------------------

### Helpful Links

These are some links that were helpful to me when I was going through
this process myself:

* Corey Haines' [talk](https://www.youtube.com/watch?v=bNn6M2vqxHE)
* Corey Haines'
  [post](http://articles.coreyhaines.com/posts/active-record-spec-helper/)
* rails cast on [fast tests](https://www.youtube.com/watch?v=Ek2iyeeL1Vc)
* Jose Valim's
  [post](http://blog.plataformatec.com.br/2011/12/three-tips-to-improve-the-performance-of-your-test-suite/)
* shared connection [gist](https://gist.github.com/josevalim/470808)
* Andre Dieb's [post](http://andredieb.com/5-ways-to-speedup-rails-feature-tests.html)
