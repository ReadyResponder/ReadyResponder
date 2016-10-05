# LIMS3

This application aids emergency management and other agencies in managing both their personnel and their equipment.

Features:

* Web-based user interface
* Tracks complete data of personnel, including attendance, responsiveness and training
* Tracks equipment, including serial numbers, sources, grants and service records
* Will produce QR Codes of people to allow easier addition into a cell phone
* will produce qr code to allow people to sign up for events
* Will contact members via email, SMS over email and VOIP to alert them
* Will capture availablity via VOIP IVR, SMS and email

## Getting Started

This is a Rails project that is configured to run on Ruby 2, and on a Postgres database.  So, the things you'll need to install before running LIMS locally are Ruby, the `bundler` gem, and Postgres version 9.

1. Ruby: There's a detailed list of options for installing Ruby on the [official Ruby website](https://www.ruby-lang.org/en/documentation/installation/).
  * [RVM](http://rvm.io/), [rbenv](https://github.com/rbenv/rbenv#readme), and [chruby](https://github.com/postmodern/chruby#readme) are common ruby installation managers for Macs & Linux.
  * The exact version of Ruby that LIMS is using is specified in the [.ruby-version](.ruby-version) file.
1. Bundler: `gem install bundler`
1. Postgres
  * If you have `homebrew` on a Mac, you can run `brew install postgres`.
  * Alternatively, [Postgres.app](http://postgresapp.com) is an easy way to get started with PostgreSQL on the Mac. [PostgresApp 9.4.8](https://github.com/PostgresApp/PostgresApp/releases/tag/9.4.8) has been tested (when configuring, add `host: localhost` to `config/database.yml`).

*Feel free to ask for help!*

#### Contributing to LIMS: Coding :smiley:

One more thing to install: The testing framework requires the [PhantomJS](http://phantomjs.org) library.  In order to code in LIMS, you'll need to install PhantomJS separately (see below).

Then get the project code locally and set it up:

1. `git clone https://github.com/ReadyResponder/ReadyResponder.git`
1. `cd ReadyResponder`
1. `bundle install`
1. Copy `config/database.example.yml` to `config/database.yml`.  Edit `config/database.yml` if necessary to match your postgres configuration.
1. `bundle exec rake db:create`
1. `bundle exec rake db:schema:load`

At this point you should be able to run the rails server via `bundle exec rails s`, the rails console via `bundle exec rails c`, and the tests via `bundle exec rspec spec/`

Note: You can use the UI to create a user and sign in, but the UI doesn't allow creation of an admin user.  To use all the features of LIMS in the browser, you will need to enable admin privileges for your local user in the rails console after signing up via the UI:

`User.first.roles << Role.where(name: "Manager").first_or_create`

#### One-time setup for tests:
```shell
bundle exec rake db:test:prepare

# install phantomjs...
# via npm:
sudo npm install -g phantomjs-prebuilt
# via homebrew:
brew install phantomjs
# on ubuntu: 
sudo apt-get install phantomjs
```

#### Project Build Status: &nbsp; [![Build Status](https://api.travis-ci.org/ReadyResponder/ReadyResponder.svg?branch=development)](https://travis-ci.org/ReadyResponder/ReadyResponder)

## More information

See [the wiki](https://github.com/ReadyResponder/ReadyResponder/wiki)!

#### Contributing to LIMS: Community Expectations :raised_hands:

We have a [Code of Conduct](CODE_OF_CONDUCT.md) to set clear expectations for community participation. We want participating in LIMS to be safe, fun, and respectful. We've adopted the ["Contributor Covenant"](http://contributor-covenant.org/) model for our code of conduct, which is the same model that [the Rails project itself](http://rubyonrails.org/conduct/) uses. (Other projects that use a Code of Conduct of this type include [RSpec](https://github.com/rspec/rspec/blob/master/code_of_conduct.md), [Jenkins](https://jenkins-ci.org/conduct/), and [RubyGems](https://github.com/rubygems/rubygems/blob/master/CODE_OF_CONDUCT.md).)

Please read the [Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
