require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  let(:customer) {customers(:two)}

  it "has valid fields" do
    assert_respond_to(customer, :email)
    assert_respond_to(customer, :first_name)
    assert_respond_to(customer, :last_name)
    assert_respond_to(customer, :phone_number)
  end

  it "has many orders and products associations" do
    binding.pry
    assert customer.orders.size > 0
    assert customer.products.size > 0
    assert_equal customer.products.size, customer.orders.first.products.size
  end

end
