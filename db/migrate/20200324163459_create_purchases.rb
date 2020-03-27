class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |purchases|
      purchases.integer :item_id
      purchases.integer :user_id
      purchases.string :item_name
      purchases.float :total_price
    end 
  end
end
