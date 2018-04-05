class Api::V1::ProductsController < Api::SecuredController


  def index
    @products = current_customer.products
    response = Hash(data: Hash(products: @products))

    render json: response.as_json, status: :ok
  end

end
