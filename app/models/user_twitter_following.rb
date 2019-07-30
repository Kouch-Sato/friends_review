# == Schema Information
#
# Table name: user_twitter_followings
#
#  id                    :bigint           not null, primary key
#  twitter_following_uid :bigint
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :integer
#

class UserTwitterFollowing < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_following,
             class_name: "User",
             optional: true,
             primary_key: "uid",
             foreign_key: "twitter_following_uid"
end
