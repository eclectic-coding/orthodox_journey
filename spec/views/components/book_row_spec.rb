# frozen_string_literal: true

require "rails_helper"

describe BookRow::Component do
  let(:book) { create(:book) }
  let(:component) { BookRow::Component.new(book: book) }

  subject { rendered_content }

  it "renders" do
    render_inline(component)

    expect(page).to have_content(book.title)
    expect(page).to have_content(book.author)
    expect(page).to have_content(book.authored_at.strftime("%y"))
  end
end
