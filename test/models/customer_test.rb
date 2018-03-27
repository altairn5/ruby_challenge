require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  let(:customer) {customer.new}

  it "has first_name field" do
    assert_respond_to(customer, :first_name)
  end

  # it "first_name value exists" do
  #   customer = customers(:one)
  # end
end
