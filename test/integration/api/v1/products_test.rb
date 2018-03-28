require 'test_helper'

class Api::V1::ProductsTest < ActionDispatch::IntegrationTest
  let(:customer) { create(:customer) } #factory_bot
  let(:order) { orders(:two) } #fixtures

  before do
    customer.orders << order
    customer.save!
  end
  # it "retrieve all products for a customer" do
  #   get api_v1_products_path()
  # end
end
