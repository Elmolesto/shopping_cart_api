# frozen_string_literal: true

require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "should create product" do
    product = Product.new(name: "Test Product", stock: 10, price_cents: 2000)
    assert product.save
    assert_equal "Product", product.type
  end

  test "should not save product without name" do
    product = Product.new(stock: 10, price_cents: 2000)
    assert_not product.save, "Saved the product without a name"
  end

  test "should not save product without stock" do
    product = Product.new(name: "Test Product", price_cents: 2000)
    assert_not product.save, "Saved the product without stock"
  end

  test "should not save product without price_cents" do
    product = Product.new(name: "Test Product", stock: 10)
    assert_not product.save, "Saved the product without price_cents"
  end
end
