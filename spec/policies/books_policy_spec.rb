require 'rails_helper'

RSpec.describe BooksPolicy, type: :policy do
  subject { described_class }

  permissions :index?, :show? do
    it "grants access to any user" do
      expect(subject).to permit(User.new, Book.new)
    end
  end
end
