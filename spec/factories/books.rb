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
FactoryBot.define do
  factory :book do
    title { "MyString" }
    author { "MyString" }
    authored_at { Time.zone.now - 10.years }
    description { nil }
    reading { false }
    completed { false }
  end
end
