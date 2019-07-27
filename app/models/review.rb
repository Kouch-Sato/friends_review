# == Schema Information
#
# Table name: reviews
#
#  id          :bigint           not null, primary key
#  book_id     :integer
#  review_type :integer
#  content     :string(255)
#  status      :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
