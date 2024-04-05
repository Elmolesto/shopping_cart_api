# frozen_string_literal: true

class Product < Item
  validates :stock, presence: true

  store_accessor :details, :stock
end
