class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name
      t.string :subdomain
      t.string :community_type
      t.string :ancestry
      t.string :region
      t.string :region_code
      t.string :country
      t.integer :country_id
      t.string :city
      t.string :state
      t.string :zip_code
      t.integer :school_id
      t.float :latitude
      t.float :longitude
      
      t.timestamps
    end
    add_index :communities, :ancestry
  end
end
