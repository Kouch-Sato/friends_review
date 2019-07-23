# == Schema Information
#
# Table name: books
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Book < ApplicationRecord
  belongs_to :user
  has_many :reviews

  scope :commented_by, -> (user) { where(id: user.reviews_to_others.pluck(:book_id).uniq) }
end
