class Product < ApplicationRecord
  include Priceable

  has_many :cart_items

  validates :name, presence: true

  scope :available, -> { where(available: true) }

  def available?
    available
  end
end
