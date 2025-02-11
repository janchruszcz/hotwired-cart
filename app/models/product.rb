class Product < ApplicationRecord
  include Priceable

  has_many :cart_items
  has_one_attached :image

  validates :name, presence: true
  validates :sku, uniqueness: true

  scope :available, -> { where(available: true) }

  def available?
    available
  end
end
