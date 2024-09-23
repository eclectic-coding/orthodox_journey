class Users::BooksController < ApplicationController
  before_action :authenticate_user!

  layout 'user'

  def index
    @books = Book.all
  end

  def show
  end
end
