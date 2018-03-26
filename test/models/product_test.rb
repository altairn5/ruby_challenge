require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  let(:product) {product.new}

  it "has price field" do
    assert_respond_to(product, :price)
  end

  # it "price value exists" do
  #   product = products(:one)
  # end
end
