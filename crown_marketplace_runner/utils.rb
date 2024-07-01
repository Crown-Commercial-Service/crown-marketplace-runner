# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

require 'yaml'
require 'colorize'

module CrownMarketplaceRunner
  module Utils
    CONFIG_FILE_PATH = 'config/crown-marketplace.yml'

    def crown_marketplace_config
      @@crown_marketplace_config ||= YAML.load_file(CONFIG_FILE_PATH).transform_keys(&:to_sym).each_with_object({}) do |item, hash|
        hash[item[0]] = item[1].map { |value| value.transform_keys(&:to_sym) }
      end
    end

    def puts(object, colour = :default)
      if object.is_a? String
        super(object.colorize(colour))
      else
        super(object)
      end
    end

    def script_name
      @@script_name ||= name[29..].gsub(/(.)([A-Z])/, '\1 \2').upcase
    end

    def run_script
      puts "##### BEGIN #{script_name} ######", :light_cyan
      yield
      puts "##### FINISH #{script_name} ######", :light_green
    end

    def run_command_in_project(name:, command:, success_message:, error_message:)
      puts "Running '#{command}' for: #{name}", :light_cyan

      Dir.chdir("code/applications/#{name}") do
        if Bundler.unbundled_system(command)
          puts "#{success_message} for: #{name}", :light_green
        else
          puts "Something went wrong, could not #{error_message} for: #{name}", :light_red
          exit_script
        end
      end
    end

    def exit_script
      puts "\n##### EXITING #{script_name} ######", :light_red
      exit 1
    end

    def check_repo_exists(name:, destination:)
      return if Dir.exist? "code/#{destination}/#{name}"

      puts "Could not find: #{name}", :light_red
      puts 'Run ./bin/setup to download repo', :light_red
      exit_script
    end
  end
end
