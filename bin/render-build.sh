#!/bin/bash

set -e

# Install dependencies
bundle install

# Precompile assets
bundle exec rake assets:precompile

# Clean assets
bundle exec rake assets:clobber

# Run database migrations
bundle exec rake db:migrate

