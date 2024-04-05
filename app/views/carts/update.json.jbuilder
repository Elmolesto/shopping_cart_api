# frozen_string_literal: true

json.status :ok
json.message message
json.total_cents @cart.total_cents
json.total_quantity @cart.total_quantity
json.cart_item @cart_item, partial: "carts/cart_item", as: :cart_item
