require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  let(:product) {products(:two)}

  it "has price field" do
    assert_respond_to(product, :price)
  end

  it "has many orders and categories" do
     assert  product.orders.size > 0
     assert  product.categories.size > 0
  end
end
