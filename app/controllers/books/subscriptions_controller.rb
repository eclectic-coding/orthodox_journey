class Books::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    subscription = current_user.subscriptions.new(book: @book)
    if subscription.save
      redirect_to users_books_path, notice: 'Subscribed to book successfully.'
    else
      redirect_to users_books_path, alert: subscription.errors.full_messages.to_sentence
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
