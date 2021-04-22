class OrderAddress
  include ActiveModel::Model
  attr_accessor :customer_id, :cart_id, :postal_code, :prefecture_id, :town, :residence, :building, :tell_number, :token

  with_options presence: true do
    validates :customer_id, :cart_id, :town, :residence, :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :tell_number, format: { with: /\A\d{10,11}\z/ }
  end
  def save
    order = Order.create(customer_id: customer_id, cart_id: cart_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, town: town, residence: residence, building: building,
                   tell_number: tell_number, order_id: order.id)
  end
end
