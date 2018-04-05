class Api::V1::OrdersController < Api::SecuredController

  def index
    @orders = current_customer.orders
    render json: ::OrderSerializer.new( @orders ), status: :ok
  end


end
