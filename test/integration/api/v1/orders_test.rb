require 'test_helper'

class Api::V1::OrdersTest < ActionDispatch::IntegrationTest
  #clean up
  describe "GET orders" do
    let(:customer) { create(:customer) } #factory_bot
    let(:products) { create_list(:product, 5) } #factory_bot

    before do
      create(:order, customer: customer, products: products)
    end

    it "retrieves all orders for a customer" do
      token = generate_auth_token( customer )
      get api_v1_orders_path(customer.id), headers: authenticated_header( token )

      assert_response :ok

      parsed_response.dig('data').tap do |json|
        assert_equal customer.orders.count,  json.dig('order_count')
        assert_equal customer.orders.first.total.as_json, json.dig('orders')[0]["total"]
      end
    end

    it "cannot retrieve orders without a valid token" do
      get api_v1_orders_path(customer.id), headers: authenticated_header

      assert_response :unauthorized
    end

  end
end
