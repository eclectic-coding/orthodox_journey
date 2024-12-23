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
  attr_accessor :authored_year

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user

  has_one_attached :image

  before_validation :convert_authored_year_to_date
  before_save :set_wiki_url
  after_commit :set_description, on: :create

  validates :title, presence: true, uniqueness: true
  validates :author, presence: true
  validates :authored_at, presence: true

  def has_subscriptions?
    subscriptions.exists?
  end

  private

  def set_wiki_url
    book_title = title.gsub(' ', '_')
    self.wiki_url ||= "https://en.wikipedia.org/wiki/#{book_title}"
  end

  def set_description
    BookMetadataJob.perform_later(self.id)
  end

  def convert_authored_year_to_date
    if authored_year.present?
      self.authored_at = Date.new(authored_year.to_i)
    end
  end
end
