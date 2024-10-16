# frozen_string_literal: true

class Admin::UserRowComponent < ApplicationComponent
  option :user

  attr_reader :user, :sign_in_date

  def sign_in_date
    user.last_sign_in_at.strftime('%m-%d-%Y %I:%M:%S %p') if user.last_sign_in_at
  end
end
