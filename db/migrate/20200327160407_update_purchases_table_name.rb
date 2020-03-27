class UpdatePurchasesTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :purchases, :cart_items
  end
end
