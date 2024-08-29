# spec/helpers/users_helper_spec.rb
require 'rails_helper'
# require 'webmock/rspec'

RSpec.describe UsersHelper, type: :helper do
  describe '#gravatar_url_for' do
    let(:email) { 'user@example.com' }
    let(:hash) { Digest::MD5.hexdigest(email.downcase) }
    let(:default_options) { { default: :mp, rating: :pg, size: 48 } }
    let(:gravatar_url) { "https://secure.gravatar.com/avatar/#{hash}.png?#{default_options.to_param}" }

    before do
      stub_request(:get, gravatar_url).to_return(status: 200)
    end

    it 'returns the correct Gravatar URL' do
      expect(helper.gravatar_url_for(email)).to eq(gravatar_url)
    end
  end
end
