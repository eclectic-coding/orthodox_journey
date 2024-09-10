require 'rails_helper'

RSpec.describe "Admin::Books", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/books/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/books/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/admin/books/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/books/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
