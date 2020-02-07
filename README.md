# ReadyResponder

**Project Build Status:** [![Build Status](https://api.travis-ci.org/ReadyResponder/ReadyResponder.svg?branch=development)](https://travis-ci.org/ReadyResponder/ReadyResponder) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/2155146098fe428d9f6e11951f5ed75a)](https://www.codacy.com/app/kfallon/ReadyResponder?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=ReadyResponder/ReadyResponder&amp;utm_campaign=Badge_Grade) [![Code Climate](https://codeclimate.com/github/ReadyResponder/ReadyResponder/badges/gpa.svg)](https://codeclimate.com/github/ReadyResponder/ReadyResponder)
[![Open Source Helpers](https://www.codetriage.com/readyresponder/readyresponder/badges/users.svg)](https://www.codetriage.com/readyresponder/readyresponder)

### This application aids volunteer organizations to manage personnel, equipment, and scheduling.

The project was inspired by [Sandi Metz's call for programmers to aid their communities](https://www.youtube.com/watch?feature=player_detailpage&v=fhpT6Pc4AqM#t=1931). This project, in particular, looks to lessons learned in response to emergencies that inspired the National ICS program. It has often been found that there are plentiful equipment and personnel, but not the organization to know what was available nor the ability to manage it.

The goal of Ready Responder is to offer volunteer groups a program that allows them to track their resources and personnel, especially during emergencies or multi-day events. This application might be used by volunteer firefighters, auxiliary police, Medical Reserve Corp (MRC), CERT organizations, amateur radio operators (ARES/RACES), church based relief groups, shelter managers or even science-fiction conventions.

## Current Features

* Web-based user interface, available from both desktop and mobile
* Tracks complete data of personnel, including attendance, responsiveness, and training
* Tracks equipment, including serial numbers, sources, grants, and service records
* Contacts members via SMS to alert them
* Produces QR Codes of people to allow easier addition into a cell phone

## Upcoming Features

* Will produce QR code to allow people to sign up for events
* Will contact members via email, SMS and VOIP to alert them

The program is currently in production, getting live feedback.

## Contributing to Ready Responder
We have a Slack channel at [readyresponder.slack.com](https://readyresponder.slack.com) to give help if you need it.

### Getting Started - Dependencies

This is a Rails project that is configured to run on Ruby 2, and on a Postgres database.

Things you'll need to install before running ReadyResponder locally are:

* Ruby Programming Language
* The `bundler` gem
* PostgreSQL (version 9) database
* ImageMagick (a dependency of the rmagick gem, used to process images)

For **ruby**, you can find a detailed list of options on the [official Ruby website](
https://www.ruby-lang.org/en/documentation/installation/). The most common
applications used to manage your ruby version are:

* [RVM](https://rvm.io)
* [rbenv](https://github.com/rbenv/rbenv#readme), with the
  [ruby-build](https://github.com/rbenv/ruby-build#readme) plugin
* [chruby](https://github.com/postmodern/chruby#readme)

The exact version of Ruby that ReadyResponder is using is specified in the
[.ruby-version](.ruby-version) file.

After setting up ruby on your system, install the `bundler` gem with `gem
install bundler`.

Below you will find instructions on installing the remaining dependencies for Mac
OS and Ubuntu.

#### Dependencies - Mac OS

Ensure you have the [Homebrew](https://brew.sh/) package manager. Run `brew
update` before you install the dependencies. You can also use other package
managers, such as [MacPorts](https://www.macports.org/install.php), but the
following instructions assume you're using Homebrew.

Install PostgreSQL

```shell
$ brew install postgres
```

Install ImageMagick

```shell
$ brew install imagemagick@6
```

#### Dependencies - Ubuntu

Run `apt-get update` before you install the dependencies.

Install PostgreSQL

```shell
$ apt-get install postgresql libpq-dev
```

Install ImageMagick

```shell
$ apt-get install libmagickwand-dev
```

*Feel free to ask for help!*

#### Vagrant Setup

We also have a Vagrant + Ansible setup so you can start quickly. See [Vagrant + Ansible](roles/)

## Running in Docker
Assuming you've got docker installed just run

```
docker-compose up -d
```
note: if you want it to run as a foreground process leave off the `-d`

The _first_ time you run it you'll also need to populate the database, so 
run this.

```
docker-compose exec rails bin/setup
```

At the end of the output you'll see the username and password for the default user.


## Contributing to ReadyResponder: Coding :smiley:

Get the project code locally and set it up:

1. Install dependencies ([Mac](#dependencies---mac-os),
   [Ubuntu](#dependencies---ubuntu))
2. [Fork](https://help.github.com/articles/fork-a-repo) ReadyResponder.
3. [Clone](https://help.github.com/articles/cloning-a-repository/) the forked
   repository to your development or local machine.
4. `cd ReadyResponder`
5. `bundle install`
6. Set up the local database
    1. Ensure the Postgres server is started
        ```shell
        $ pg_ctl -D /usr/local/var/postgres start
        ```
    2. Ensure you have a user for the database
        ```shell
        $ sudo -i -u postgres
        $ createuser -P --interactive <database-username>
        $ exit
        ```
        Enter a password and answer the prompts, you will have a user (role)
        named <database-username> with the selected privileges. **Make sure the new
        role can create databases**
    3. Copy the example database configuration file
        ```shell
        $ cp config/database.example.yml config/database.yml
        ```
    4. Fill in the copied file with your database user information and add
        an entry with `host: localhost`. Edit both the `development` and `test`
        keys
    5. Create the databases (test and development) and apply the schema defined in
        `db/schema.rb`
        ```shell
        $ bundle exec rake db:create
        $ bundle exec rake db:schema:load
        ```
7. Seed the database with some sample data and create an admin for you to use on the local server
    ```shell
    $ bundle exec rake db:seed
    ```
    **You should note the output of the db:seed, as it will spit out the password at the end.**

At this point you should be able to run the rails server via `bundle exec rails s`, the rails console via `bundle exec rails c`, and the tests via `bundle exec rspec spec/`.

### One-time setup for tests

```shell
$ bundle exec rake db:test:prepare
```

> Note: The testing framework will run much faster over time if you run it via Spring. When running rake enter `bin/rake` to execute via Spring pre-loader.

## More information

See [the wiki](https://github.com/ReadyResponder/ReadyResponder/wiki)!

## Contributing to ReadyResponder: Community Expectations :raised_hands:

We have a [Code of Conduct](CODE_OF_CONDUCT.md) to set clear expectations for community participation. We want your participation in ReadyResponder to be safe, fun, and respectful. We've adopted the ["Contributor Covenant"](http://contributor-covenant.org/) model for our code of conduct, which is the same model that [the Rails project itself](http://rubyonrails.org/conduct/) uses. (Other projects that use a Code of Conduct of this type include [RSpec](https://github.com/rspec/rspec/blob/master/code_of_conduct.md), [Jenkins](https://jenkins-ci.org/conduct/), and [RubyGems](https://github.com/rubygems/rubygems/blob/master/CODE_OF_CONDUCT.md).)

Please read the [Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
