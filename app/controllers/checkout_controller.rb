class CheckoutController < ApplicationController

  before_action :authenticate_user!

  # Success
  def single_checkout_success
	 SuccessPurchase.(checkout_params).single_checkout
	 redirect_to_profile I18n.t('checkout_success_message')
  end

  def cart_checkout_success
	 SuccessPurchase.(checkout_params).cart_checkout
	 redirect_to_profile I18n.t('checkout_success_message')
  end

  # Pending

  def single_checkout_pending
	 PendingCartPurchase.for(current_user, purchase_params)
	 redirect_to_profile redirect_to_cart I18n.t('checkout_pending_message')
  end

  def cart_checkout_pending
	 PendingCartPurchase.for(current_user, purchase_params)
	 redirect_to_profile redirect_to_cart I18n.t('checkout_pending_message')
  end

  # Cancelled

  def single_checkout_cancelled
	 CancelSinglePurchase.for(current_user, purchase_params)
	 redirect_to_cart I18n.t('checkout_cancelled_message')
  end

  def cart_checkout_cancelled
	 CancelCartPurchase.for(current_user, purchase_params)
	 redirect_to_cart I18n.t('checkout_cancelled_message')
  end

  private
  def set_product
	 @product = Product.friendly.find(params[:product_id])
  end

  def mercado_pago_params
	 params.permit(:collection_id, :preference_id, :payment_type, :collection_status)
  end

  def checkout_params
	 params[:user] = current_user
	 params[:mercado_pago_params] = mercado_pago_params
	 params
  end

  def redirect_to_profile message = nil
	 flash[:notice] = message unless message.nil?
	 redirect_to profile_path
  end

  def redirect_to_cart message = nil
	 flash[:notice] = message unless message.nil?
	 redirect_to cart_path
  end

end
