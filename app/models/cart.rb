class Cart < ApplicationRecord
  has_many :item_carts, dependent: :destroy
end
