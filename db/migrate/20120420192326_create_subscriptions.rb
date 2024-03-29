class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.integer :plan_id
      t.string :description
      t.string :stripe_customer_token

      t.timestamps
    end
    add_index :subscriptions, :user_id
  end
end
