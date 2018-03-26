class Placement < ApplicationRecord
  belongs_to :orders, inverse_of: :placements
  belongs_to :products, inverse_of: :placements
end
