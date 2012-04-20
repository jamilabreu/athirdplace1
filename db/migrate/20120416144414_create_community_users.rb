class CreateCommunityUsers < ActiveRecord::Migration
  def change
    create_table :community_users do |t|
      t.references :community
      t.references :user

      t.timestamps
    end
    add_index :community_users, :community_id
    add_index :community_users, :user_id
  end
end
