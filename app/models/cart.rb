class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def total_price
    cart_items.sum(&:subtotal)
  end

  def discounted_total(discount = 0)
    [ total_price - discount, 0 ].max
  end
end
