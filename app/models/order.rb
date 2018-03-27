class Order < ApplicationRecord
  before_validation :get_total

  belongs_to :customer
  has_many :placements
  has_many :products, through: :placements


  # default: :pending
  validates :total, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :customer_id, presence: true

  enum status: [:pending, :shipped, :delivered]

  private

  def get_total
    self.total = self.products.map(&:price).sum
  end
end
