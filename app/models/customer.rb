class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many  :cart_items
  has_many  :items

   validates :sunname, presence: true
   validates :name, presence: true

   validates :sunname_kana, presence: true
   validates :name_kana, presence: true

   validates  :postal_code, presence: true

   validates :address, presence: true

   validates :telephone_number, presence: true


end
