class Placement < ApplicationRecord
  belongs_to :order, inverse_of: :placements
  belongs_to :product, inverse_of: :placements


  def product_quantity
    self.quantity
  end

  #
  # callbacks
  #
  before_save :set_quantity

  def parse_date( day )
    day = day.is_a?( Date ) ? day : Date.parse(day.to_s).beginning_of_day
  end

  private

  def set_quantity
    return if self.quantity > 1
    self.quantity = 1
  end

  class << self

    def sort_by_range(starts, ends, day_week_or_month=nil)
      starts = parse_start_date( starts )
      ends   = parse_end_date( ends )
      day_week_or_month||='day'
      products_sold = {}
      # binding.pry
      placements = where(created_at: starts..ends).group_by{ |placement| placement.created_at.send("beginning_of_#{day_week_or_month}") }
      placements.each do |k, v|
        products_sold[k] =  placements[k].map{ |purchase| purchase.product.as_json.merge(quantity: purchase.quantity) }
      end
      products_sold
    end

    def parse_start_date( day )
      day = day.is_a?( Date ) ? day : Date.parse(day.to_s).beginning_of_day
    end

    def parse_end_date( day )
      day = day.is_a?( Date ) ? day : Date.parse(day.to_s).end_of_day
    end

  end
end
