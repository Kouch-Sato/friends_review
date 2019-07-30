class CreateUserTwitterFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_twitter_followers do |t|
      t.integer :user_id
      t.bigint :twitter_follower_uid

      t.timestamps
    end
  end
end
