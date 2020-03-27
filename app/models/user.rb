class User < ActiveRecord::Base
    has_many(:cart_items)

    def add_to_cart(selected_item)
        if selected_item.stock == 0
            puts "\n#{selected_item.name} is currently out of stock.\n".red
        else
            CartItem.create(item_id: selected_item.id, user_id: $current_user.id, item_name: selected_item.name, total_price: selected_item.price)
            selected_item.stock -= 1
            selected_item.save
        end
    end 
    
    def remove_from_cart(item_to_delete)
        cart_item = self.cart_items.find_by(item_name: item_to_delete)
        item = cart_item.item
        item.stock += 1 
        item.save
        cart_item.destroy
        return CartItem.all.where(user_id: self.id)
    end
end
