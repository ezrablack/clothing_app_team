class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |purchase|
      purchase.integer :item_id
      purchase.integer :user_id
      purchase.string :item_name
      purchase.float :total_price
    end 
  end
end
