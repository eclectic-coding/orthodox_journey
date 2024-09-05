class Admin::UsersController < ApplicationController
  before_action :authenticate_user!

  layout 'admin'

  def index
    authorize current_user, policy_class: AdminPolicy

    @users = User.all
  end

  def show
  end
end
