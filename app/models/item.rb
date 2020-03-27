class Item < ActiveRecord::Base
    has_many(:purchases)
end 