require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get books_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      book = create(:book)
      get book_path(book)
      expect(response).to have_http_status(:success)
    end
  end
end
