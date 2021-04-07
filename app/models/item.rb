class Item < ApplicationRecord
 belongs_to :corporation
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  has_one_attached :image
end
