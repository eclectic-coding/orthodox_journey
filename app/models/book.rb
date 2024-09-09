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
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Book < ApplicationRecord
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user
end
