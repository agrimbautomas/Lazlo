class CartController < ApplicationController

  before_action :authenticate_user!

  def show

  end


  def checkout
    params[:product_rows]= current_user.checkout_list.product_rows
    CheckoutMercadoPago.(parameters: params, delegate: self)
  end


end
