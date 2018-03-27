require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  let(:order) { Order.new }
  let(:order_two){ orders(:two) }

  it "has total field" do
    assert_respond_to(order, :total)
  end

  it "has correct total value" do
    sum = 0
    order_two.send(:get_total)
    order_two.products.each{|x| sum += x.price }

    assert_equal order_two.total, sum
  end

end
