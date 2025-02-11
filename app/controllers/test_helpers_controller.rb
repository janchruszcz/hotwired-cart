class TestHelpersController < ApplicationController
  def set_cart
    session[:cart_id] = params[:id]
    head :ok
  end
end
