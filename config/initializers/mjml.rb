# frozen_string_literal: true

Rails.application.configure do
  config.mjml.bin_path = '/usr/bin/env mjml'
  config.mjml.logger = MJML::Logger.setup!(STDOUT)
  config.mjml.minify_output = true
  config.mjml.validation_level = :soft
end
