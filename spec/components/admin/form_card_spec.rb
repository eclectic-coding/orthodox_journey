# frozen_string_literal: true

require "system_helper"

describe Admin::FormCardComponent, type: :component do
  let(:options) { { title: "Test Title" } }
  let(:component) { Admin::FormCardComponent.new(**options) }

  subject { rendered_content }

  it "renders" do
    render_inline(component)

    expect(page).to have_css("h2", text: "Title")
  end
end
