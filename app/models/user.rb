class User < ActiveRecord::Base
    has_many(:purchases)

    def remove_from_cart(item_to_delete)
        purchase = self.purchases.find_by(item_name: item_to_delete)
        item = purchase.item
        item.stock += 1 
        item.save
        purchase.destroy
        return Purchase.all.where(user_id: self.id)
    end
end
