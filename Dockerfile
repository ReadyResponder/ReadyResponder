FROM ruby:2.6

LABEL maintainer="masukomi@masukomi.org"
ENV DEBIAN_FRONTEND noninteractive

# allow apt to work with https-based sources
RUN apt-get update -yqq && \
    apt-get upgrade -yqq && \
    apt-get install -yqq --no-install-recommends \
      apt-utils \
      apt-transport-https

## Install packages
RUN apt-get update -yqq && \
    apt-get install -yqq --no-install-recommends \
      postgresql-client\
      imagemagick

COPY Gemfile* /usr/src/app/

WORKDIR /usr/src/app

# we're going to store the gems in a volume
# so that we're not constantly re-downloading all of them
ENV BUNDLE_PATH /gems

RUN gem update --system
RUN gem install bundler:1.16.6
RUN gem install rake:12.3.1

RUN bundle install

COPY . /usr/src/app/

# compensate for rails failing to always clean up
# after itself (server.pid gets left sometimes)
ENTRYPOINT ["./docker-entrypoint.sh"]

# Go speed racer! Go!
CMD ["bin/rails", "s", "-b", "0.0.0.0"]
