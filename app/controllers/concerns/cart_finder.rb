module CartFinder
  extend ActiveSupport::Concern

  included do
    before_action :set_cart
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end
end
