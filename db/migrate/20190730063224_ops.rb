class Ops < ActiveRecord::Migration[5.2]
  def change
    rename_table :user_twitter_following, :user_twitter_followings
  end
end
