require 'rails_helper'

RSpec.describe "Books::Subscriptions", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/books/subscriptions/create"
      expect(response).to have_http_status(:success)
    end
  end
end
