require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

require 'view_component'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsOrthodoxJourney
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join("app", "views", "components")
    config.view_component.preview_paths << Rails.root.join("app", "views", "components")
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets generators tasks templates])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Eastern Time (US & Canada)"
    config.eager_load_paths << Rails.root.join("app", "views", "components")

    config.generators do |g|
      g.system_tests = nil
      g.helper = false
      g.test_framework :rspec,
        view_specs: false,
        routing_specs: false,
        controller_specs: false
    end

    # Conditionally require generators only in non-production environments
    unless Rails.env.production?
      require "rails/generators"
    end
  end
end
