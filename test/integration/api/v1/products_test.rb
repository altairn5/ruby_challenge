require 'test_helper'

class Api::V1::ProductsTest < ActionDispatch::IntegrationTest

  describe "GET Products" do
    let(:customer) { create(:customer) }
    let(:products) { create_list(:product, 5) }
    let(:login )   { Hash(auth: Hash(email: customer.email, password: customer.password)) }

    before do
      create(:order, products: products, customer: customer)
    end

    it "retrieve all products for a customer" do
      post api_v1_auth_path, params: login
      token = parsed_response.dig('data', 'jwt')

      get api_v1_products_path, headers: authenticated_header( token )
      assert_response :ok

      parsed_response.dig('data').tap do |json|

        assert json.key?('products')
        assert_equal json.dig('products').count, customer.products.count
      end
    end

  end
end
