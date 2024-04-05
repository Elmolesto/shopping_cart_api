# frozen_string_literal: true

require "test_helper"

class CartItemTest < ActiveSupport::TestCase
  test "should create cart item" do
    cart = carts(:one)
    product = products(:one)
    cart_item = CartItem.new(cart:, item: product, quantity: 1)
    assert cart_item.save
  end

  test "should not save cart item without cart" do
    product = products(:one)
    cart_item = CartItem.new(item: product, quantity: 1)
    assert_not cart_item.save, "Saved the cart item without a cart"
  end

  test "should not save cart item without item" do
    cart = carts(:one)
    cart_item = CartItem.new(cart:, quantity: 1)
    assert_not cart_item.save, "Saved the cart item without an item"
  end

  test "should not save cart item without quantity" do
    cart = carts(:one)
    product = products(:one)
    cart_item = CartItem.new(cart:, item: product)
    assert_not cart_item.save, "Saved the cart item without a quantity"
  end

  test "should not save cart item with zero quantity" do
    cart = carts(:one)
    product = products(:one)
    quantity = 0
    cart_item = CartItem.new(cart:, item: product, quantity:)
    assert_not cart_item.save, "Saved the cart item without a quantity"
  end
end
