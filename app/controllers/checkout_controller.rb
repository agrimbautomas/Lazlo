class CheckoutController < ApplicationController

  before_action :authenticate_user!

  # Success
  def single_checkout_success
	 SaveSinglePurchase.for(current_user, purchase_params)
	 redirect_to_profile I18n.t('checkout_success_message')
  end

  def cart_checkout_success
	 SaveCartPurchase.for(current_user, purchase_params)
	 redirect_to_profile I18n.t('checkout_success_message')
  end


  # Pending

  def single_checkout_pending
	 params = purchase_params
	 params[:message] = 'dejó pendiente'

	 send_admin_email params
	 flash[:notice] = 'Su compra NO se concretó, quedó pendiente, Gracias.'
	 redirect_to product_path @product
  end

  def single_checkout_failure
	 params = purchase_params
	 params[:message] = 'canceló'

	 send_cancelled_purcharse_email params
	 flash[:notice] = 'Su compra ha sido cancelada. Gracias.'
	 redirect_to product_path @product
  end

  def cart_checkout_pending
	 params = purchase_params
	 params[:message] = 'dejó pendiente'

	 send_admin_email params
	 flash[:notice] = 'Su compra NO se concretó, quedó pendiente, Gracias.'
	 redirect_to product_path @product
  end

  def cart_checkout_failure
	 params = purchase_params
	 params[:message] = 'canceló'

	 send_cancelled_purcharse_email params
	 flash[:notice] = 'Su compra ha sido cancelada. Gracias.'
	 redirect_to product_path @product
  end

  private
  def set_product
	 @product = Product.friendly.find(params[:product_id])
  end

  def purchase_params
	 params.permit(:collection_id, :preference_id, :payment_type, :collection_status)
  end

  def redirect_to_profile message = nil
	 flash[:notice] = message unless message.nil?
	 redirect_to profile_path
  end
end
