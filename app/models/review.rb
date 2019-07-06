class Review < ApplicationRecord
  # TODO:ログインしてるユーザーの場合はレビューをユーザーと紐付ける
  belongs_to :book
end
