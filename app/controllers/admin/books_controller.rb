class Admin::BooksController < ApplicationController
  before_action :authenticate_user!

  layout "admin"

  def index
    authorize current_user, policy_class: AdminPolicy

    @books = Book.all
  end

  def show
  end

  def new
  end

  def edit
  end

  private

end
