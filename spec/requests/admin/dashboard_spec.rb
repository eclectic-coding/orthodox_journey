require 'rails_helper'

RSpec.describe "Admin::Dashboards", type: :request do
  describe "GET /show" do
    it "returns http success" do
      sign_in create(:user, :admin)
      get admin_dashboard_show_path
      expect(response).to have_http_status(:success)
    end
  end
end
