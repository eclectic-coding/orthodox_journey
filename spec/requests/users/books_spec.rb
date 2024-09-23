require 'rails_helper'

RSpec.describe "Users::Books", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/users/books/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/users/books/show"
      expect(response).to have_http_status(:success)
    end
  end
end
