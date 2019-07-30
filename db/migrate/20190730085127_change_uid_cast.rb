class ChangeUidCast < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :uid, :bigint
  end
end
