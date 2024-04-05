# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  validate :cart_items_uniqueness

  def total_cents
    cart_items&.sum(&:subtotal_cents)
  end

  def total_quantity
    cart_items&.sum(&:quantity)
  end

  private

  def cart_items_uniqueness
    if cart_items.map(&:product_id).uniq.length != cart_items.length
      errors.add(:cart_items, "should only be one per item")
    end
  end
end
