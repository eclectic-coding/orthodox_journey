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
class Book < ApplicationRecord
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user

  before_save :set_wiki_url
  after_commit :set_description, on: :create

  private

  def set_wiki_url
    self.wiki_url ||= "https://en.wikipedia.org/wiki/#{title}"
  end

  def set_description
    p "Enqueuing job for Book ID: #{self.id}"
    BookMetadataJob.perform_later(self.id)
  end
end
