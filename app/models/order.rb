class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :cart
  has_one :address
end
