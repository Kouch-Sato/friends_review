class ChangeUidCast < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :uid, :bigint
  end

  def down
    change_column :users, :uid, :string
  end
end
