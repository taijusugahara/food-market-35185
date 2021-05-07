class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :name, :birthday
    with_options format: { with: /[^ -~｡-ﾟ]+/ } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: /[\p{katakana}　ー－]+/ } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end
  validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/ }

  has_many :orders
end
