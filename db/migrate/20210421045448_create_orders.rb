class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.references :cart, foreign_key: true
      t.timestamps
    end
  end
end
