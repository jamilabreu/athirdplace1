class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.text :body_html
      t.string :post_type

      t.timestamps
    end
  end
end
