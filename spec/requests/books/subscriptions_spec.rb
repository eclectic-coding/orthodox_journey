require 'rails_helper'

RSpec.describe "Books::Subscriptions", type: :request do
  before do
    sign_in create(:user)
    @book = create(:book)
  end

  describe "POST /create" do
    it "returns http success" do
      post book_subscriptions_path(@book), params: { book_id: @book.id }
      expect(response).to have_http_status(:redirect)
    end
  end
end
