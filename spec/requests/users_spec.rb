require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /show" do
    it "returns http success" do
      sign_in create(:user)
      get user_root_path
      expect(response).to have_http_status(:success)
    end

    it "returns http failure for not logged in guest" do
      get "/users/show"
      expect(response).to_not have_http_status(:success)
    end
  end
end
