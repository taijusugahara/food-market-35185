class ItemCart < ApplicationRecord
  belongs_to :item
  belongs_to :cart
  
  validates :item_id, presence: true
end
