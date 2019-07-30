class ChangeModelNameOfFollowers < ActiveRecord::Migration[5.2]
  def change
    rename_table :user_twitter_followers, :user_twitter_following
  end
end
