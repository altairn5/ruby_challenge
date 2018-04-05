class Customer < ApplicationRecord

  has_secure_password validations: false

  has_many :orders, dependent: :destroy
  has_many :products, through: :orders

  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
end
