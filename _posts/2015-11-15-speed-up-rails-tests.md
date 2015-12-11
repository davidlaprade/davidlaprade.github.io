---
title: "Speed Up Rails Tests"
excerpt: "I recently cut the run time of my company's test suite by 32 min on CI, and 21 min locally. Here's how."
---

It's very easy to write slow tests as a Rails developer.
As a result, test suite run times are often very long.
This makes them impractical to run frequently, and thus mostly useless.
There are many suggestions out there as to how to speed them up.
Here's what I found most useful.

### Local Changes
The following changes dramatically improved the run time of our test suite
locally.

__1. Record/Stub All API Calls__

Our test suite was making live API calls. A lot of them. Often to very slow API's.
\*cough\* NetSuite \*cough\*.

I decided to record all of the responses to our API calls with VCR. This has
been written about in a few places. For example:
[here](http://railscasts.com/episodes/291-testing-with-vcr), and
[here](https://robots.thoughtbot.com/how-to-stub-external-services-in-tests).

To do this, I made the following additions:

{% highlight ruby %}
# ./Gemfile
group :test do
  gem 'webmock', require: false
  gem 'vcr', require: false
end

# ./spec/spec_helper.rb
require 'webmock/rspec'
require 'vcr'
WebMock.disable_net_connect! :allow_localhost => true

# ./spec/support/vcr.rb
VCR.configure do |c|
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [
      :uri,
     #:body, uncomment if you need fine-grained control of recordings
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
calls were made, the recordings would automatically be played back. This
saved close to 10 minutes once it was correctly configured.

### CI Changes
The following changes dramatically improved the run time of our test suite
on our continuous integration server.

__1. Decrease Ruby's Garbage Collection Frequency__

This has been suggested by many people in many places. For example:
[here](http://collectiveidea.com/blog/archives/2015/02/19/optimizing-rails-for-memory-usage-part-2-tuning-the-gc/),
[here](https://ariejan.net/2011/09/24/rspec-speed-up-by-tweaking-ruby-garbage-collection/),
[here](http://railscasts.com/episodes/413-fast-tests), and
[here](https://gist.github.com/burke/1688857).

This change was especially helpful to us because (a) we were running ruby 1.9.3
and (b) we had a rather involved CI build. We were calling `bundle exec`
8-or-so times during each run! Adding the following variables to our CI
container environment shaved 10 minutes off the build time:

{% highlight bash %}
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_FREE_MIN=500000
export RUBY_HEAP_MIN_SLOTS=40000
{% endhighlight %}

This made ruby eat up much more memory, but dramatically increased speed. Fine
by us, since this was just on CI!

Ultimately, we bumped our version of ruby to 2.1.6 -- which is dramatically
better about garbage collection than 1.9.3 -- and this was the final fix for the
issue. In all, however, this one change probably made the biggest difference to
the build time on CI.

__2. Decrease Rails' Load Frequency

Remember those 8 `bunde exec` calls I mentioned earlier?



Replace slow capybara calls
  * profile them to find out which

Block requests to external URLS in integration specs
  * how to do this with a custom driver

Clean db with transactions
  * hack to do this in integration tests




### Local Improvements

### Improvements on CI

-----------------------
### Helpful Links
corey haines' talk
corey haines' post
rails cast
post about magic ENV vars to speed up ruby
shared connection post



