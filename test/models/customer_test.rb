require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  #
  # Fixtures
  #
  let(:customer) { customers(:two) }
  let(:order) { orders(:two) }
  #
  # factory_bog
  #
  let(:user) { build(:customer) }
  let(:valid_customer) { Customer.new(first_name: 'John', email: 'john@example.com', phone_number: "123") }

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
    before do
      customer.orders << order
      customer.save!
    end

    it "has many orders and products associations" do
      assert customer.orders.size > 0
      assert customer.products.size > 0
      assert_equal customer.products.size, customer.orders.first.products.size
    end

  end
end
