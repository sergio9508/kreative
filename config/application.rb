# frozen_string_literal: true
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LatteCms
  #
  class Application < Rails::Application
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Central America'
    config.i18n.default_locale = :es
    config.i18n.fallbacks = true
    config.i18n.available_locales = %i[es en]
    config.autoload_paths << Rails.root.join('app').join('pdf')
  end
end
