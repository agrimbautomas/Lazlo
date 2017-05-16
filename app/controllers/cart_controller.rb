class CartController < ApplicationController

  before_action :authenticate_user!

  def show

  end


  def checkout
    params[:product_rows] = current_user.checkout_list.product_rows
    checkoutMp = CheckoutMercadoPago.(parameters: params, delegate: self)
    checkoutMp
    byebug
  end


end
