class Users::BooksController < ApplicationController
  before_action :authenticate_user!

  layout 'user'

  def index
  end

  def show
  end
end
