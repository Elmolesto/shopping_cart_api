# frozen_string_literal: true

class Item < ApplicationRecord
  validates :name, presence: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }

  def product?
    type == "Product"
  end

  def event?
    type == "Event"
  end
end
