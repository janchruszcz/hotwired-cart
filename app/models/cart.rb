class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  validates :discount, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
  }

  def total_price
    cart_items.sum(&:subtotal)
  end

  def discounted_total
    [ total_price - discount, 0 ].max
  end

  def empty?
    cart_items.empty?
  end

  def valid_for_checkout?
    cart_items.any? && cart_items.all?(&:valid?)
  end
end
