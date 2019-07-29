# == Schema Information
#
# Table name: user_twitter_followers
#
#  id                   :bigint           not null, primary key
#  twitter_follower_uid :bigint
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :integer
#

class UserTwitterFollower < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_follower,
             class_name: "User",
             optional: true,
             primary_key: "uid",
             foreign_key: "twitter_follower_uid"
end
