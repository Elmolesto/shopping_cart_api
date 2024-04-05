# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  before_save :check_stock, if: :item_product?

  validates :quantity, numericality: { greater_than: 0 }

  def subtotal_cents
    quantity * item.price_cents
  end

  private

  def item_product?
    item.product?
  end

  def check_stock
    return if item.stock >= quantity

    errors.add(:quantity, "exceeds stock")
    throw(:abort)
  end
end
