class OrderSerializer < ApplicationSerializer
  attr_reader :orders, :total_count

  def initialize( orders, options ={})
    @orders = orders
    @total_count = orders.count

    super(options)
  end

  def data
    Hash(
      order_count: total_count,
      orders: serialize_orders
    )
  end

  #
  #
  # serializer methods
  #
  #
  def serialize_orders
    orders.map do |o|
      o.as_json(except: [:id, :created_at, :updated_at, :customer_id]).merge(products_builder(o) )
    end
  end

  def products_builder(order)
    prods = order.products.map do |prod|
      prod.as_json(except: [:id, :created_at, :updated_at])
    end
    
    Hash(products: prods)
  end

end
