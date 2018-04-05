require 'test_helper'

class ReportsTest < ActionDispatch::IntegrationTest

  it "should get all products with no auth token" do
    get reports_products_url, params: {}, headers: authenticated_header( nil )
    assert_response :success
  end

  #clean up
  describe "Products" do
    let(:start_date) { (Time.now - 7.days).strftime("%Y-%m-%d") }
    let(:end_date) { (Time.now + 2.day).strftime("%Y-%m-%d") }
    let(:cust) { create(:customer) }
    let(:products) { create_list(:product, 10) }
    let(:order) { build(:order, products: products, customer: cust) }
    let(:product_params) { Hash(start_date: start_date,end_date: end_date) }

    before do
      prods_and_quantities = products.map{ |prod| [prod.id, rand(2..10)] }
      order.multiple_quantities(prods_and_quantities)
      order.save!
    end

    it "handles start and end date product_params" do
      get reports_products_url, params: Hash(products: product_params), headers: authenticated_header
        assert_response :ok

        parsed_response.dig('data').tap do |json|
          assert  json.key?('items_sold')
          assert  json.key?('sorted_by')
          assert  json.key?('products')
          assert_match %r{\d{4}-\d{2}-\d{2}}, parsed_response.dig("data", "products").keys[0]
        end
    end

    it "handles sort_by product_params" do
      get reports_products_url, params: Hash(products: product_params.merge(sort_by: 'week') ), headers: authenticated_header
        assert_response :ok

        parsed_response.dig('data').tap do |json|
          assert  json.key?('items_sold')
          assert  json.key?('sorted_by')
          assert  json.key?('products')
          assert_equal parsed_response.dig("data", "sorted_by"), 'week'
        end
    end

  end
end
