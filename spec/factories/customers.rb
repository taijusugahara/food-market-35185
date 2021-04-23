FactoryBot.define do
  factory :customer do
    name              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 4) }
    password_confirmation { password }
    first_name            { '大樹' }
    last_name             { '菅原' }
    first_name_kana            { 'タイジュ' }
    last_name_kana             { 'スガハラ' }
    birthday { Faker::Date.in_date_period }
  end
end
