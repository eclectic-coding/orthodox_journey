class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.ses[:from_email]
  layout "mailer"
end
