# == Schema Information
#
# Table name: books
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Book < ApplicationRecord
  belongs_to :user
  has_many :reviews

  def checked_review(num=0)
    reviews.checked[num]
  end
end
