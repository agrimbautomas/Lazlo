class CartController < ApplicationController

  before_action :authenticate_user!

  def show

  end


  def checkout
    params[:user] = current_user
    @checkout_link = CheckoutMercadoPago.(parameters: params, delegate: self).payment_link
  end


end
