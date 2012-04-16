class UserUidToBigint < ActiveRecord::Migration
  def up
    change_column :users, :uid, :bigint
  end

  def down
    change_column :users, :uid, :bigint
  end
end
