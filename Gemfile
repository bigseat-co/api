source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '6.1.1'
gem 'pg'
gem 'puma'
gem 'redis'
gem 'bootsnap', require: false
gem 'rack-cors'
gem 'sidekiq'

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :development, :test do
  gem 'pry'
  gem 'rspec'
end

group :development do
  gem 'listen'
  gem 'spring'
end

