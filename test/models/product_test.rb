require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:speaker)
  end

  test "valid product" do
    assert @product.valid?
  end

  test "requires name" do
    @product.name = nil
    assert_not @product.valid?
    assert_not_nil @product.errors[:name]
  end

  test "requires price" do
    @product.price = nil
    assert_not @product.valid?
    assert_not_nil @product.errors[:price]
  end

  test "price must be non-negative" do
    @product.price = -1
    assert_not @product.valid?
    assert_not_nil @product.errors[:price]
  end

  test "requires unique sku" do
    duplicate = Product.new(
      name: "Test Product",
      price: 100,
      sku: @product.sku
    )
    assert_not duplicate.valid?
    assert_not_nil duplicate.errors[:sku]
  end
end
