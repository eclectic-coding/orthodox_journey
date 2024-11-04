# frozen_string_literal: true

RSpec.configure do |config|
  config.include Warden::Test::Helpers # helpers for system tests
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :component
  config.include Devise::Test::ControllerHelpers, type: :component
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.before(:each, type: :component) do
    @request = vc_test_controller.request
  end
end
