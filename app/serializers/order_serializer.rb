class OrderSerializer < ApplicationSerializer
  attr_reader :order


  def initialize( order, options ={} )
    @order = order

    super(options)
  end

  def data
    # Hash(
    #   id:
    #   total: order.address_type,
    # )
  end

end
