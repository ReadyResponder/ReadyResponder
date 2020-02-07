#!/bin/sh

set -e
# I don't know why I have to do this install of bundler itself.
# It _should_ have been taken care of by the Dockerfile
# but...
gem install bundler:1.17.3

bin/bundle install

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi
exec "$@"
