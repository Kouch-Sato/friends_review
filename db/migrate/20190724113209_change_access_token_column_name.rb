class ChangeAccessTokenColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :twitter_access_token, :access_token
    rename_column :users, :twitter_access_token_secret, :access_token_secret
  end
end
