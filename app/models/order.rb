class Order < ApplicationRecord
  has_many :order_details #中間テーブル
  has_many :items, through: :order_details  #注文には商品が多くある
  belongs_to :customer
  enum status: {
     "入金待ち":0,
     "入金確認":1,
     "製作中":2,
     "発送準備中":3,
     "発送済み":4
  }

  enum payment_method: { credit_card: 0, transfer: 1 }
end
