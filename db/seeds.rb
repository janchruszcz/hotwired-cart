# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Creating products..."

products = [
  {
    name: 'Wireless speaker, Goodyear',
    price: 100.00,
    sku: 'SPKR-001',
    description: 'High-quality wireless speaker with exceptional sound'
  },
  {
    name: "Woman's Home Suit, Sweet Dreams",
    price: 25.00,
    sku: 'SUIT-001',
    description: 'Comfortable home suit for relaxation'
  },
  {
    name: 'Raincoat, SwissOak',
    price: 50.00,
    sku: 'COAT-001',
    description: 'Waterproof raincoat for all weather conditions'
  }
]

products.each do |product_data|
  product = Product.create!(
    name: product_data[:name],
    price: product_data[:price],
    sku: product_data[:sku],
    description: product_data[:description]
  )
end

puts "Seed completed successfully!"
