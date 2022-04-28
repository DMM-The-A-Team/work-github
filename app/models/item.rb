class Item < ApplicationRecord
  has_many :order_details  #中間テーブル
  has_many :orders, through: :order_details
  has_many :cart_items
  #belongs_to :customer

  has_one_attached :image
end
