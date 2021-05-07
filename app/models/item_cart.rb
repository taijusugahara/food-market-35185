class ItemCart < ApplicationRecord
  belongs_to :item
  belongs_to :cart
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
end
