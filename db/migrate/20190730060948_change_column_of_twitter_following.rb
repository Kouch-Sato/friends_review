class ChangeColumnOfTwitterFollowing < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_twitter_following, :twitter_follower_uid, :twitter_following_uid
  end
end
