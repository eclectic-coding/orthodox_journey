class ApplicationViewComponent < ViewComponentContrib::Base
  extend Dry::Initializer
  include Dry::Effects::Handler.Reader(:current_user, default: nil)
end
