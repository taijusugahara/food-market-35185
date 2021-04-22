class Cart < ApplicationRecord
  has_many :item_carts, dependent: :destroy
  has_one :order
end
