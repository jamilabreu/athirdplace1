class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name
      t.string :subdomain
      t.string :community_type
      t.string :ancestry

      t.timestamps
    end
    add_index :communities, :ancestry
  end
end
