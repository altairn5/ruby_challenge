class OrderSerializer < ApplicationSerializer
  attr_reader :orders, :total_count

  # change entity to data
  def initialize( orders, options ={entity: 'orders'})
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
      o.as_json(except: [:id, :created_at, :updated_at, :customer_id])
    end
  end

end
