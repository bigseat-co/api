source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.0'
gem 'pg'
gem 'puma', '~> 5.0'
#gem 'redis', '~> 4.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'rack-cors'
gem 'sidekiq', '~> 6.1.2'
gem 'sidekiq-cron', '~>1.2.0'

group :development, :test do
  gem 'pry'
  gem 'rspec'
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'rubocop-rails', require: false
  gem 'rubocop-performance', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
