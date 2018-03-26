class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :placements
  has_many :orders, through: :placements

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0}, presence: true
end
