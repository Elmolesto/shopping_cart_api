# frozen_string_literal: true

json.(@cart, :id, :created_at, :updated_at, :total_cents, :total_quantity)
json.cart_items @cart.cart_items do |cart_item|
  json.partial!("carts/cart_item", cart_item:)
  json.item cart_item.item, :id, :name, :type, :price_cents
end
