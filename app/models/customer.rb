class Customer < ApplicationRecord
  has_many :order, dependent: :destroy
  has_many :products, through: :orders

  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
end
