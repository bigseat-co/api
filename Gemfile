# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', require: false
gem 'pg'
gem 'puma'
gem 'rack-cors'
gem 'rails', '6.1.1'
gem 'redis'
gem 'mjml'
gem 'sidekiq'
gem 'figaro'

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development, :test do
  gem 'pry'
  gem 'rspec'
end

group :development do
  gem 'listen'
  gem 'spring'
end
