# frozen_string_literal: true

require "rails_helper"

describe UserRow::Component do
  let(:user) { create(:user) }
  let(:options) { { user: user } }
  let(:component) { UserRow::Component.new(**options) }

  subject { rendered_content }

  it "renders" do
    render_inline(component)

    expect(page).to have_content(user.email)
    expect(page).to have_content(user.role)
    expect(page).to have_content(user.sign_in_count)
    expect(page).to have_content(component.sign_in_date)
  end
end
