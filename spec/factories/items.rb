FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word }
    category_id { 2 }
    price { 10_000 }
    association :corporation

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/sample1.png'), filename: 'sample1.png')
    end
  end
end
