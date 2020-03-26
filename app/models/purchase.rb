#do we want to change to Cart??
class Purchase < ActiveRecord::Base
    belongs_to(:user)
    belongs_to(:item)
end


