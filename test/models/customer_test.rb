require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  let(:valid_customer) { Customer.create!(first_name: 'John', email: 'john@example.com', phone_number: "123") }
  #
  # factory_bot
  #
  let(:customer) { create(:customer) }
  let(:products) { create_list(:product, 2) }

  it "is valid user" do
    assert valid_customer.valid?
  end

  it "has valid fields" do
    assert_respond_to(customer, :email)
    assert_respond_to(customer, :first_name)
    assert_respond_to(customer, :last_name)
    assert_respond_to(customer, :phone_number)
  end

  describe "customer associations" do
    let(:order) { create(:order, products: products, customer: customer) }

    it "has many orders and products associations" do
      customer.reload
      order.reload
      assert customer.orders.size > 0
      assert customer.products.size > 0
      assert_equal customer.products.size, order.products.size
    end

  end
end
