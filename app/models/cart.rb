class Cart < ApplicationRecord
  has_many :item_carts, dependent: :destroy
  has_many :items, through: :item_carts
end
