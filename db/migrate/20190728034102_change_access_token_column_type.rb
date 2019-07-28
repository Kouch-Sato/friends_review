class ChangeAccessTokenColumnType < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :access_token, :string
    change_column :users, :access_token_secret, :string
  end

  def down
    change_column :users, :access_token, :binary
    change_column :users, :access_token_secret, :binary
  end
end
