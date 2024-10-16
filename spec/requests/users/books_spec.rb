require 'rails_helper'

RSpec.describe "Users::Books", type: :request do
  before do
    sign_in create(:user)
  end

  describe "GET /index" do
    it "returns http success" do
      get users_books_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      book = create(:book)
      get users_book_path(book)
      expect(response).to have_http_status(:success)
    end
  end
end
