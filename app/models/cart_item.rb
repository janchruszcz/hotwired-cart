class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true,
    numericality: { greater_than: 0, only_integer: true }
  validate :product_still_available

  delegate :name, :price, to: :product, prefix: true

  def subtotal
    product_price * quantity
  end

  private

  def product_still_available
    return unless product
    errors.add(:product, "is no longer available") unless product.available?
  end
end
