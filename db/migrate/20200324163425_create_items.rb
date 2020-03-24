class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |item|
      item.string :name
      item.float :price
    end
  end
end