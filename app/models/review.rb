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
  # TODO:ログインしてるユーザーの場合はレビューをユーザーと紐付ける
  belongs_to :book
end
