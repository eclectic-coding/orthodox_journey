class Admin::BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[ show edit update ]

  layout "admin"

  def index
    authorize current_user, policy_class: AdminPolicy

    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    p "params: #{params}"
    @book = Book.create!(book_params)

    if @book.save
      redirect_to admin_books_path
    else
      render :new
    end

  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to admin_books_path
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book)
          .permit(:title, :author, :authored_at, :authored_year, :description, :reading, :completed, :wiki_url, :reading_url)
          .tap do |book_params|
      if book_params[:authored_at].present?
        book_params[:authored_at] = DateTime.new(book_params[:authored_at].to_i)
      end
    end
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
