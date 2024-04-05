# frozen_string_literal: true

require "test_helper"

class CartApiTest < ActionDispatch::IntegrationTest
  test "client can create a cart and add items to it" do
    # Create a new cart
    post carts_url, as: :json
    assert_response :created

    # Check that the cart was created
    cart_id = response.parsed_body.dig("id")
    cart = Cart.find(cart_id)

    # Add an item to the cart
    item = products(:one)
    post add_cart_url(cart.id, item.id), as: :json
    assert_response :success

    # Add another item to the cart
    item = products(:two)
    post add_cart_url(cart, item.id), as: :json
    assert_response :success

    # Check that the cart has the correct items
    get cart_url(cart), as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 2, json_response["cart_items"].count
    assert_equal 2, json_response["total_quantity"]
    assert_equal 7998, json_response["total_cents"]
  end

  test "client can change the quantity of an item in the cart" do
    # Create a new cart
    post carts_url, as: :json
    assert_response :created

    # Check that the cart was created
    cart_id = response.parsed_body.dig("id")
    cart = Cart.find(cart_id)

    # Add an item to the cart
    item = events(:three)
    post add_cart_url(cart.id, item.id), as: :json
    assert_response :success

    # Add the same item to the cart
    post add_cart_url(cart.id, item.id), as: :json
    assert_response :success

    # Check that the cart has the correct items
    get cart_url(cart), as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 1, json_response["cart_items"].count
    assert_equal 2, json_response["total_quantity"]
    assert_equal 7998, json_response["total_cents"]

    # Remove one of the same item from the cart
    delete remove_cart_url(cart.id, item.id), as: :json
    assert_response :success

    # Check that the cart has the correct items
    get cart_url(cart), as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 1, json_response["cart_items"].count
    assert_equal 1, json_response["total_quantity"]
    assert_equal 3999, json_response["total_cents"]
  end

  test "client cannot add more items than in stock" do
    # Create a new cart
    post carts_url, as: :json
    assert_response :created

    # Check that the cart was created
    cart_id = response.parsed_body.dig("id")
    cart = Cart.find(cart_id)

    # Add an item to the cart
    item = products(:two) # Only one in stock
    post add_cart_url(cart.id, item.id), as: :json
    assert_response :success

    # Check that the cart has the correct items
    get cart_url(cart), as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 1, json_response["cart_items"].count
    assert_equal 1, json_response["total_quantity"]
    assert_equal 3999, json_response["total_cents"]

    # Add another item to the cart
    post add_cart_url(cart.id, item.id), as: :json
    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_match "Quantity exceeds stock", json_response["message"].to_s
  end
end
