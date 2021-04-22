class Item < ApplicationRecord
  belongs_to :corporation
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  has_one_attached :image
  has_many :item_carts, dependent: :destroy
  with_options presence: true do
    validates :image, :name, :price
    with_options numericality: { other_than: 1 } do
      validates :category_id
    end
  end
end
