# frozen_string_literal: true

json.array!(@items) do |item|
  json.extract! item, :id, :name, :description, :thumbnail,
                :type, :price_cents, :created_at, :updated_at
  if item.product?
    json.stock item.stock
  elsif item.event?
    json.date item.date
  end
end
