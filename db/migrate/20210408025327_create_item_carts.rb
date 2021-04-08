class CreateItemCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :item_carts do |t|
      t.integer :quantity, default: 0
      t.references :item, foreign_key: true
      t.references :cart, foreign_key: true
      t.timestamps
    end
  end
end
