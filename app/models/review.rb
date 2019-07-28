# == Schema Information
#
# Table name: reviews
#
#  id          :bigint           not null, primary key
#  content     :string(255)
#  review_type :integer
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  book_id     :integer
#  user_id     :integer
#

class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user, optional: true
  has_many   :replies

  validates :review_type, presence: true
  validates :content,     presence: true, length: { minimum: 1, maximum: 50 }
  validates :status,      presence: true

  enum status: { unchecked: 10, checked: 20, deleted: 30 }
  enum review_type: { good: 1, bad: 2 }
end
