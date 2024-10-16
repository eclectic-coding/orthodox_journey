# frozen_string_literal: true

require "system_helper"

describe Admin::BookRowComponent, type: :component do
  let(:book) { create(:book) }
  let(:component) { Admin::BookRowComponent.new(book: book) }

  subject { rendered_content }

  it "renders" do
    render_inline(component)

    expect(subject).to have_content(book.title)
    expect(subject).to have_content(book.author)
    expect(subject).to have_content(book.authored_at.strftime("%y"))
  end
end
