class AddTwitterAccessTokenColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitter_access_token, :binary
    add_column :users, :twitter_access_token_secret, :binary
  end
end
