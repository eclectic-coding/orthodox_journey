class Users::BooksController < ApplicationController
  before_action :authenticate_user!

  layout 'user'

  def index
    @books = Book.all
    @my_books = current_user.subscribed_books
  end

  def show
  end
end
