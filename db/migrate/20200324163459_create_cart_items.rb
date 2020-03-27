class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |cart_item|
      cart_item.integer :item_id
      cart_item.integer :user_id
      cart_item.string :item_name
      cart_item.float :total_price
    end 
  end
end
