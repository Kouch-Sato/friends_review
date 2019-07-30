class ChangeUidCast < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :uid, :string
    add_column :users, :uid, :bigint
  end
end
