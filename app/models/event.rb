# frozen_string_literal: true

class Event < Item
  validates :date, presence: true

  store_accessor :details, :date
end
