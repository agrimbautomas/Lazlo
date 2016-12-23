class PurchaseController < ApplicationController

  before_action :authenticate_user!, :set_product

  def purchase_success
    purchase_params[:message] = 'Concretó'
    UserMailer.purchase_product(purchase_params).deliver_now
    flash[:notice] = 'Muchas gracias por comprar en Macain! En breve nos vamos a estar contactando para coordinar la entrega. Gracias!'
    product_path @product
  end

  def purchase_pending
    purchase_params[:message] = 'Dejó pendiente'
    UserMailer.purchase_product(purchase_params).deliver_now
    flash[:notice] = 'Su compra NO se concretó, quedó pendiente, Gracias.'
    product_path @product
  end

  def purchase_failure
    purchase_params[:message] = 'Canceló'
    UserMailer.purchase_product(purchase_params).deliver_now
    flash[:notice] = 'Su compra ha sido cancelada. Gracias.'
    product_path @product
  end


  private
  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

  def purchase_params
    {
        :user => current_user,
        :product_name => @product[:name],
        :message => 'Concretó'
    }
  end

end
