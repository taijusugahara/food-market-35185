class Item < ApplicationRecord
  belongs_to :corporation
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  has_one_attached :image
  has_many :item_carts
  has_many :carts, through: :item_carts
  has_many :check_items
end
