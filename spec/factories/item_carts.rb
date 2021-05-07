FactoryBot.define do
  factory :item_cart do
    quantity { 5 }
    association :item
    association :cart
  end
end
