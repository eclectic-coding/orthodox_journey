if ENV["RAILS_ENV"] ||= "test"
  require "simplecov"
  SimpleCov.start "rails" do
    add_filter "/app/channels/"
    add_filter "/app/jobs/"
    add_filter "/app/mailers/"
    add_filter "/lib/"
  end
end

require "spec_helper"

ENV["RAILS_ENV"] ||= "test"

require_relative "../config/environment"
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "view_component/test_helpers"
require "view_component/system_test_helpers"
require "capybara/rspec"
require "capybara/rails"
require "capybara/rspec"
require "fuubar"
require "pundit/rspec"
require "webmock/rspec"

Rails.root.glob("spec/support/**/*.rb").sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.include ViewComponent::TestHelpers, type: :component
  config.include ViewComponent::SystemTestHelpers, type: :component
  config.include Capybara::RSpecMatchers, type: :component

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_paths = [
    Rails.root.join("spec/fixtures")
  ]
  config.use_transactional_fixtures = true
  config.include FactoryBot::Syntax::Methods
  config.include Warden::Test::Helpers # helpers for system tests
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :component
  config.include Devise::Test::ControllerHelpers, type: :component
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Turbo::FramesHelper, type: :system
  config.include Turbo::StreamsHelper, type: :system

  config.before(:each, type: :component) do
    @request = vc_test_controller.request
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.fuubar_progress_bar_options = { format: "Completed Tests <%B> %p%% %a" }
end
