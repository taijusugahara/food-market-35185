FactoryBot.define do
  factory :order_address do
    token { 'tok_abcdefghijk' }
    postal_code { '123-4567' }
    prefecture_id { 2 }
    town { '大阪市' }
    residence { '北区2-3-3' }
    building { 'マンション' }
    tell_number { '0123456789' }
  end
end
