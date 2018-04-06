require 'test_helper'

class Api::V1::OrdersTest < ActionDispatch::IntegrationTest

  describe "GET orders" do
    let(:customer) { create(:customer) }
    let(:products) { create_list(:product, 5) }
    let(:token)    { generate_auth_token( customer ) }
    let(:customer_order) { create(:order, customer: customer, products: products) }

    before do
      new_order = Order.create!(customer: customer, products: products)
    end

    it "retrieves all orders for a customer" do
      get api_v1_orders_path(customer.id), headers: authenticated_header( token )
      assert_response :ok
      parsed_response.dig('data').tap do |json|

        assert_equal customer.orders.count,  json.dig('order_count')
        assert_equal customer.orders.first.total, products.map(&:price).sum
      end
    end

    it "cannot retrieve orders without a valid token" do
      get api_v1_orders_path(customer.id), headers: authenticated_header

      assert_response :unauthorized
    end

  end
end
