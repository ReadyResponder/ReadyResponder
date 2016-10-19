## ReadyResponder

#### Project Build Status: &nbsp; [![Build Status](https://api.travis-ci.org/ReadyResponder/ReadyResponder.svg?branch=development)](https://travis-ci.org/ReadyResponder/ReadyResponder)

### This application aids volunteer organizations to manage personnel, equipment and scheduling.

The project was inspired by [Sandi Metz's call for programmers to aid their communities](https://www.youtube.com/watch?feature=player_detailpage&v=fhpT6Pc4AqM#t=1931) .  This project in particular looks to lessons learned in response to emergencies that inspired the National ICS program.  It has often been found that there is plentiful equipment and personnel, but not the organization to know what was available nor the ability to manage it.

The goal of Ready Responder is to offer volunteer groups a program that allows them to track their resources and personnel, especially during emergencies or multi-day events.  This application might be used by volunteer firefighters, auxiliary police, Medical Reserve Corp (MRC), CERT organizations, amateur radio operators (ARES/RACES), church based relief groups, shelter managers or even science-fiction conventions.

#### Current Features:
* Web-based user interface, available from both desktop and mobile
* Tracks complete data of personnel, including attendance, responsiveness and training
* Tracks equipment, including serial numbers, sources, grants and service records

#### Upcoming Features
* Will produce QR Codes of people to allow easier addition into a cell phone
* Will produce QR code to allow people to sign up for events
* Will contact members via email, SMS and VOIP to alert them

The program is currently in production, getting live feedback.

## Contributing to Ready Responder
We have a Slack channel at [readyresponder.slack.com](readyresponder.slack.com) to give help if you need it.

### Getting Started

This is a Rails project that is configured to run on Ruby 2, and on a Postgres database.  So, the things you'll need to install before running ReadyResponder locally are Ruby, the `bundler` gem, and Postgres version 9.

1. Ruby: There's a detailed list of options for installing Ruby on the [official Ruby website](https://www.ruby-lang.org/en/documentation/installation/).
  * [RVM](http://rvm.io/), [rbenv](https://github.com/rbenv/rbenv#readme), and [chruby](https://github.com/postmodern/chruby#readme) are common ruby installation managers for Macs & Linux.
  * The exact version of Ruby that ReadyResponder is using is specified in the [.ruby-version](.ruby-version) file.
1. Bundler: `gem install bundler`
1. Postgres
  * If you have `homebrew` on a Mac, you can run `brew install postgres`.
  * Alternatively, [Postgres.app](http://postgresapp.com) is an easy way to get started with PostgreSQL on the Mac. [PostgresApp 9.4.8](https://github.com/PostgresApp/PostgresApp/releases/tag/9.4.8) has been tested (when configuring, add `host: localhost` to `config/database.yml`).

  One more thing to install: The testing framework requires the [PhantomJS](http://phantomjs.org) library.  In order to code in ReadyResponder, you'll need to install PhantomJS separately.

```
# install phantomjs...
# via npm:
sudo npm install -g phantomjs-prebuilt
# via homebrew:
brew install phantomjs
# on ubuntu:
sudo apt-get install phantomjs
```

*Feel free to ask for help!*

### Contributing to ReadyResponder: Coding :smiley:

Then get the project code locally and set it up:

1. `git clone https://github.com/ReadyResponder/ReadyResponder.git`
1. `cd ReadyResponder`
1. `bundle install`
1. Copy `config/database.example.yml` to `config/database.yml`.  Edit `config/database.yml` if necessary to match your postgres configuration.
1. `bundle exec rake db:create`
1. `bundle exec rake db:schema:load`
1. `bundle exec rake db:seed  `

You should note the output of the db:seed, as it will spit out the password at the end.

At this point you should be able to run the rails server via `bundle exec rails s`, the rails console via `bundle exec rails c`, and the tests via `bundle exec rspec spec/`

### One-time setup for tests:
```shell
bundle exec rake db:test:prepare
```

## More information

See [the wiki](https://github.com/ReadyResponder/ReadyResponder/wiki)!

#### Contributing to ReadyResponder: Community Expectations :raised_hands:

We have a [Code of Conduct](CODE_OF_CONDUCT.md) to set clear expectations for community participation. We want participating in ReadyResponder to be safe, fun, and respectful. We've adopted the ["Contributor Covenant"](http://contributor-covenant.org/) model for our code of conduct, which is the same model that [the Rails project itself](http://rubyonrails.org/conduct/) uses. (Other projects that use a Code of Conduct of this type include [RSpec](https://github.com/rspec/rspec/blob/master/code_of_conduct.md), [Jenkins](https://jenkins-ci.org/conduct/), and [RubyGems](https://github.com/rubygems/rubygems/blob/master/CODE_OF_CONDUCT.md).)

Please read the [Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
