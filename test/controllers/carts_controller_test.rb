# frozen_string_literal: true

require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = Cart.create
  end

  test "should create cart" do
    assert_difference("Cart.count") do
      post carts_url, as: :json
    end

    assert_response :created
  end

  test "should show cart" do
    get cart_url(@cart), as: :json
    assert_response :success
  end

  test "should respond with not found if cart does not exist" do
    get cart_url(id: 0), as: :json
    assert_response :not_found
  end

  test "should add cart_item to cart if item is not already present" do
    item = products(:two)
    assert_difference("@cart.cart_items.count") do
      post add_cart_url(@cart, item_id: item.id), as: :json
    end

    assert_response :success
  end

  test "should update cart_item quantity if item is already present" do
    item = products(:one)
    @cart.cart_items.create(item:, quantity: 1)
    assert_no_difference("@cart.cart_items.count") do
      post add_cart_url(@cart, item_id: item.id), as: :json
    end

    assert_response :success
  end

  test "should remove cart_item from cart if item quantity is zero" do
    item = events(:three)
    @cart.cart_items.create(item:, quantity: 1)
    assert_difference("@cart.cart_items.count", -1) do
      delete remove_cart_url(@cart, item_id: item.id), as: :json
    end

    assert_response :success
  end

  test "should not add item if stock is not available" do
    item = products(:one)
    item.update(stock: 0)
    assert_no_difference("CartItem.count") do
      post add_cart_url(@cart, item_id: item.id), as: :json
    end

    assert_response :unprocessable_entity
  end
end
