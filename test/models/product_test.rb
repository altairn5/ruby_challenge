require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  let(:customer) { create(:customer) }
  let(:product)  { create(:product) }

  it "has price field" do
    assert_respond_to(product, :price)
  end

  describe "associations" do

    before do
      create(:order, customer: customer, products: [product])
    end

    it { assert_respond_to(product, :placements) }
    it { assert_respond_to(product, :orders) }
    it { assert_respond_to(product, :categories) }

    it "has many orders and categories" do
       assert  product.orders.size > 0
       assert  product.categories.size > 0
    end

  end
end
