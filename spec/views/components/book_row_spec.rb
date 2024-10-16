# frozen_string_literal: true

require "system_helper"

describe BookRow::Component, type: :component do
  it "renders" do
    book = create(:book)

    render_inline(described_class.new(book: book))

    expect(subject).to have_content(book.title)
    expect(subject).to have_content(book.author)
    expect(subject).to have_content(book.authored_at.strftime("%y"))
  end
end
