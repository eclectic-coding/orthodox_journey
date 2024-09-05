# frozen_string_literal: true

require "rails_helper"

describe PageTitle::Component do
  let(:options) { { title: "Title" } }
  let(:component) { PageTitle::Component.new(**options) }

  subject { rendered_content }

  it "renders" do
    render_inline(component)

    expect(page).to have_css("h1", text: "Title")
  end
end
