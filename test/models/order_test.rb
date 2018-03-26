require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  let(:order) {Order.new}

  it "has total field" do
    # binding.pry
    assert_respond_to(order, :total)
  end

  it "total value exists" do
    order = orders(:one)
  end

end
