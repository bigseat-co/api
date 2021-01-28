# frozen_string_literal: true

namespace :bigseat do
  namespace :services do
    def assert_docker_compose_installed!
      unless system('docker-compose -v > /dev/null 2>&1')
        warn <<~EOS
          **************************************************
          ⛔️ ERROR: services tasks depend on Docker Compose being installed. \
          See https://docs.docker.com/compose/install/ for how to install.
          **************************************************
        EOS
        exit
      end
    end

    def compose_file_path
      Rails.root.join('docker-compose.yml').to_s
    end

    def compose_env
      {
        'COMPOSE_FILE' => compose_file_path,
        'COMPOSE_PROJECT_NAME' => File.basename(Dir.pwd)
      }
    end

    desc 'Start background services for this app'
    task up: :environment do
      puts 'Starting services...'
      assert_docker_compose_installed!

      if system(compose_env, "docker-compose up -d #{ENV['COMPOSE_ARGUMENTS']}")
        puts '✅ Success! Bigseat services are running in the background. Run bigseat:services:down to stop them.'
      else
        warn '⛔️ Error! There was an error starting Bigseat services.'
      end
    end

    desc 'Stop external services for this app'
    task down: :environment do
      puts 'Stopping services...'
      assert_docker_compose_installed!

      if system(compose_env, "docker-compose down #{ENV['COMPOSE_ARGUMENTS']}")
        puts '✅ Success! Bigseat services are stopped. Run bigseat:services:up to start them.'
      else
        warn '⛔️ Error! There was an error stopping Bigseat services.'
      end
    end

    desc 'Remove data volumes associated with external services. Stops containers.'
    task clean: :environment do
      puts 'Removing services data...'
      assert_docker_compose_installed!

      if system(compose_env, "docker-compose down -v #{ENV['COMPOSE_ARGUMENTS']}")
        puts '✅ Success! Bigseat service volumes have been removed. Run bigseat:services:up to start services and recreate volumes.'
      else
        warn '⛔️ Error! There was an error removing Bigseat service volumes.'
      end
    end
  end
end
