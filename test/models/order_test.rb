require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  let(:product)  { create(:product) }
  let(:customer) { create(:customer) }
  let(:order)    { create(:order, products: [product], customer: customer)}

  it "has total field" do
    assert_respond_to(order, :total)
  end

  describe "associations" do
    let(:product_1) { create(:product, :multiple_categories) }
    let(:product_2) { create(:product) }
    let(:new_order) { customer.orders.build }

    it { assert_respond_to(order, :placements) }
    it { assert_respond_to(order, :products) }

    #clean up
    it "can order multiple quantities of the same product" do
      assert_difference ->{new_order.placements.size}, 2 do
        new_order.multiple_quantities([[product_1.id, 10], [product_2.id, 5]])
        new_order.save!
      end

    end

    it "has correct total amount" do
      new_order.multiple_quantities([[product_1.id, 10], [product_2.id, 5]])
      new_order.save!
      prices = (product_1.price * 10) + (product_2.price * 5)

      assert_equal new_order.total, prices
    end

  end
end
