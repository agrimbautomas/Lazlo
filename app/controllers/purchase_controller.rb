class PurchaseController < ApplicationController

  before_action :authenticate_user!

  def purchase_success
	 SavePurchase.for(current_user, purchase_params)
	 flash[:notice] = 'Muchas gracias por comprar en Macain! En breve nos vamos a estar contactando para coordinar la entrega. Gracias!'
	 redirect_to product_path @product
  end

  def purchase_pending
	 params = purchase_params
	 params[:message] = 'dejó pendiente'

	 send_admin_email params
	 flash[:notice] = 'Su compra NO se concretó, quedó pendiente, Gracias.'
	 redirect_to product_path @product
  end

  def purchase_failure
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

  def send_purchase_product_email purchase_params
	 AdminMailer.purchase_product_admin_email(purchase_params).deliver_now
  end

  def send_cancelled_purcharse_email purchase_params
	 AdminMailer.purchase_product_admin_email(purchase_params).deliver_now
  end

end
