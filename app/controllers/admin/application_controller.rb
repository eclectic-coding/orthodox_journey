class Admin::ApplicationController < ActionController::Base
  before_action :authenticate_admin_user!

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user&.admin?
  end
end
