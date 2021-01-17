# require 'sidekiq'
# require 'sidekiq/web'
# require 'sidekiq/testing'

# Sidekiq.configure_server do |config|
#   config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
# end

# Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
#   [user, password] == [ENV.fetch('BASIC_AUTH_USERNAME', 'admin'), ENV.fetch('BASIC_AUTH_PASSWORD', 'admin')]
# end

# if Rails.env.development?
#   Sidekiq::Testing.inline!
# end