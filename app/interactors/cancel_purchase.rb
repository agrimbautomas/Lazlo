class CancelPurchase < Purchase

  def self.create_order
	 @order = Order.create(
		  :user => @user,
		  :order_products_list => order_products_list,
		  :title => "[CANCELLED] #{title}",
		  :payment_type => Order.payment_types[:mercado_pago],
		  :order_status => nil,
		  :detail => order_detail
	 )
	 checkout
  end

  private

  def self.create_mercado_pago_order
	 #Todo - Remove hardcoded status and add response status
	 @order.create_mercado_pago_purchase(
		  :status => MercadoPagoPurchase.statuses['cancelled'],
		  :preference_id => @purchase_params['preference_id'],
		  :collection_id => @purchase_params['collection_id'],
		  :payment_type => @purchase_params['payment_type'],
	 )
  end

  def self.send_response_email
	 BackgroundJob.run_block do
		params = @purchase_params
		params[:order] = @order
		params[:user] = @user

		AdminMailer.cancelled_purchase_admin_email(params).deliver_now
	 end
  end

end
