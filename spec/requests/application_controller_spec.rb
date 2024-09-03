# spec/controllers/application_controller_spec.rb
require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def dummy
      render plain: 'dummy'
    end

    def resource_class
      User
    end

    public :after_sign_in_path_for
  end

  before do
    routes.draw { get 'dummy' => 'anonymous#dummy' }
  end

  describe '#configure_permitted_parameters' do
    let(:params) { ActionController::Parameters.new }

    before do
      allow(controller).to receive(:devise_controller?).and_return(true)
      allow(controller).to receive(:devise_parameter_sanitizer).and_return(Devise::ParameterSanitizer.new(User, :user, params))
      controller.instance_eval { configure_permitted_parameters }
    end

    it 'permits name parameter for sign_up' do
      params.merge!(user: { name: 'John', email: 'john@example.com', password: 'password' })
      allow(controller).to receive(:params).and_return(params)
      permitted_params = controller.devise_parameter_sanitizer.sanitize(:sign_up)
      expect(permitted_params.keys).to include('name')
    end

    it 'permits name for account_update' do
      params.merge!(user: { name: 'John', email: 'john@example.com', password: 'password' })
      allow(controller).to receive(:params).and_return(params)
      permitted_params = controller.devise_parameter_sanitizer.sanitize(:account_update)
      expect(permitted_params.keys).to include('name')
    end
  end

  describe '#after_sign_in_path_for' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }

    before do
      sign_in user
    end

    it 'redirects to admin_root_path for admin users' do
      sign_in admin
      expect(controller.after_sign_in_path_for(admin)).to eq(admin_root_path)
    end

    it 'redirects to root_path for non-admin users' do
      expect(controller.after_sign_in_path_for(user)).to eq(user_root_path)
    end
  end
end
