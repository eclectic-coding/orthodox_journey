class UsersController < ApplicationController
  before_action :authenticate_user!

  layout 'user'

  def show
  end
end
