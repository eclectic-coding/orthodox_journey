class Admin::DashboardController < Admin::ApplicationController
  layout 'admin'

  def show
    authorize current_user, policy_class: AdminPolicy
  end
end
