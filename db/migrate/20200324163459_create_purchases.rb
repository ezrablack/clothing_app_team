class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |purchase|
      purchase.integer :item_id
      purchase.integer :user_id
    end 
  end
end
