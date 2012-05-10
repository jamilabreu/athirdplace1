class CreateCommunityPosts < ActiveRecord::Migration
  def change
    create_table :community_posts do |t|
      t.references :community
      t.references :post

      t.timestamps
    end
    add_index :community_posts, :community_id
    add_index :community_posts, :post_id
  end
end
