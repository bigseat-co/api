# Bigseat API

An API worth coding.

## Requirements
- Docker Desktop (https://www.docker.com/products/docker-desktop)
- Ruby 3.0.0
- Bundler 2.2.3

## Setup

```
# Pull project
$ git clone https://github.com/bigseat-co/api.git

# Go to project folder
$ cd cosmo-music

# Install dependencies
#
# Notes:
#
# If you get an error such as `Could not find 'bundler' (2.2.3)`,
# just run `gem install bundler -v 2.2.3` beforehand.
#
# If you get an error such as `An error occurred while installing pg (x.x.x)`,
# just run `brew install postgresql`
#
$ bundle install

# Mount environment
# => Don't forget to have docker app mac running in the background
$ bundle exec rake bigseat:services:up

# Seed project
$ bundle exec rake db:seed

# Woop woop!
$ bundle exec rails s

# Don't forget to unmount the environment
# when you finished work / want to switch to another project
$ bundle exec rake bigseat:services:down
```