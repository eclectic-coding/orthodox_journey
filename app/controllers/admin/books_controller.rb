class Admin::BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[ show edit ]

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

  def set_book
    @book = Book.find(params[:id])
  end
end
