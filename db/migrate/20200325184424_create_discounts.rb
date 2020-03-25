class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |d|
      d.string :name
      d.integer :value
    end
  end
end
