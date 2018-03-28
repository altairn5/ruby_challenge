class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_customer
  
  def index
    @orders = current_customer.orders
    render json: ::OrderSerializer.new( @orders ), status: :ok
  end

  private


end
