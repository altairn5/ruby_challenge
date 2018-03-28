class Placement < ApplicationRecord
  belongs_to :order, inverse_of: :placements
  belongs_to :product, inverse_of: :placements


  # def product_quantity(prod)
  #   count = product.orders.first.select
  # end
end
