class CartPresenter
  def initialize(cart)
    @cart = cart
  end

  def total_display
    helpers.number_to_currency(@cart.total_price)
  end

  def discounted_total_display
    helpers.number_to_currency(@cart.discounted_total)
  end

  def discount_display
    helpers.number_to_currency(@cart.discount)
  end

  def empty_state?
    @cart.empty?
  end

  private

  def helpers
    ApplicationController.helpers
  end
end
