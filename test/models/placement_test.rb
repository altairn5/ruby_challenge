require 'test_helper'

class PlacementTest < ActiveSupport::TestCase
  #clean up
  describe "Placement" do
    let(:placement) { Placement.new }

    it { assert_respond_to(placement, :quantity) }

    describe "associations" do
      it { assert_respond_to(placement, :order_id) }
      it { assert_respond_to(placement, :product_id) }
    end

  end
end
