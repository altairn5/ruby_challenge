class Order < ApplicationRecord
  #
  # Associations
  #
  belongs_to :customer
  has_many :placements
  has_many :products, through: :placements

  #
  # Validations
  #
  before_validation :get_total!
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :customer_id, presence: true

  # default: :pending
  enum status: [:pending, :shipped, :delivered]

  #
  # Callbacks
  #
  # before_validation :get_total!

  #
  # instance methods
  #
  def multiple_quantities( products_and_quatities)
    products_and_quatities.each do | quantity |
      self.placements.build(product_id: quantity[0], quantity: quantity[1])
    end
  end

  private

  def get_total!
    self.total = 0
    self.placements.each do |placement|
      self.total += placement.product.price * placement.product_quantity
    end
  end

end
