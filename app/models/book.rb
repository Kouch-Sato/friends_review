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

  def checked_review(num=0)
    reviews.checked[num]
  end
end
