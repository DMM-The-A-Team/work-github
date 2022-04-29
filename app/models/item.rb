class Item < ApplicationRecord
  has_many :order_details  #中間テーブル
  has_many :orders, through: :order_details
  has_many :cart_items
  #belongs_to :customer

  has_one_attached :image
  def get_tax_include_price
    (price*1.1).floor
  end
end
