class User < ActiveRecord::Base
    has_many(:purchases)

    def add_to_cart(selected_item)
        if selected_item.stock == 0
            puts "\n#{selected_item.name} is currently out of stock.\n".red
        else
            Purchase.create(item_id: selected_item.id, user_id: $current_user.id, item_name: selected_item.name, total_price: selected_item.price)
            selected_item.stock -= 1
            selected_item.save
        end
    end 
    
    def remove_from_cart(item_to_delete)
        purchase = self.purchases.find_by(item_name: item_to_delete)
        item = purchase.item
        item.stock += 1 
        item.save
        purchase.destroy
        return Purchase.all.where(user_id: self.id)
    end
end
