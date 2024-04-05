# frozen_string_literal: true

require "test_helper"

class CartTest < ActiveSupport::TestCase
  test "should create cart" do
    cart = Cart.new
    assert cart.save
  end
end
