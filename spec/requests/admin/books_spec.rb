require 'rails_helper'

RSpec.describe "Admin::Books", type: :request do
  before do
    sign_in create(:user, :admin)
  end

  describe "GET /index" do
    it "returns http success" do
      get admin_books_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get admin_book_path(create(:book))
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_admin_book_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      book = create(:book)
      get edit_admin_book_path(book)
      expect(response).to have_http_status(:success)
    end
  end
end
