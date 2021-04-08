class Cart < ApplicationRecord
  has_many :item_carts
  has_many :items, through: :item_carts
end
