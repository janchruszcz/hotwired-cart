class Product < ApplicationRecord
  include Priceable

  has_many :cart_items

  validates :name, presence: true
  validates :sku, uniqueness: true

  scope :available, -> { where(available: true) }

  def available?
    available
  end
end
