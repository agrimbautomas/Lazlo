class PurchaseController < ApplicationController

  before_action :authenticate_user!, :set_product

  def purchase_success
    purchase_params[:message] = 'Concretó'
    send_admin_email purchase_params
    flash[:notice] = 'Muchas gracias por comprar en Macain! En breve nos vamos a estar contactando para coordinar la entrega. Gracias!'
    redirect_to product_path @product
  end

  def purchase_pending
    purchase_params[:message] = 'Dejó pendiente'
    send_admin_email purchase_params
    flash[:notice] = 'Su compra NO se concretó, quedó pendiente, Gracias.'
    redirect_to product_path @product
  end

  def purchase_failure
    purchase_params[:message] = 'Canceló'
    send_admin_email purchase_params
    flash[:notice] = 'Su compra ha sido cancelada. Gracias.'
    redirect_to product_path @product
  end


  private
  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

  def purchase_params
    {
        :user => current_user,
        :product => @product,
        :message => 'Concretó',
        :image => URI.join(request.url, @product.image.url(:big) )
    }
  end

  def send_admin_email purchase_params
    AdminMailer.purchase_product_admin_notification(purchase_params).deliver_now
  end

end
