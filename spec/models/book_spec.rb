# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  author      :string
#  authored_at :datetime
#  completed   :boolean          default(FALSE)
#  description :text
#  reading     :boolean          default(FALSE)
#  reading_url :string
#  title       :string
#  wiki_url    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# spec/models/book_spec.rb

require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'callbacks' do
    let(:book) { build(:book, title: 'Test Book') }

    it 'sets the wiki_url before saving' do
      book.save
      expect(book.wiki_url).to eq('https://en.wikipedia.org/wiki/Test_Book')
    end

    it 'enqueues a job to set description after creation' do
      expect {
        book.save
      }.to have_enqueued_job(BookMetadataJob).with(book.id)
    end
  end
end
