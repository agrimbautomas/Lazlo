class SuccessPurchase < Purchase

  def self.create_order
	 @order = Order.create(
		  :user => @user,
		  :order_products_list => order_products_list,
		  :payment => payment,
		  :title => title,
		  :payment_type => Order.payment_types[:mercado_pago],
		  :order_status => OrderStatus.find_by_name('Encargado'),
		  :detail => order_detail
	 )
	 create_mercado_pago_order
	 checkout
  end


  private

  def self.create_mercado_pago_order
	 @order.create_mercado_pago_purchase(
		  :status => @purchase_params['collection_status'],
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

		UserMailer.success_purchase_user_email(params).deliver_now
		AdminMailer.success_purchase_admin_email(params).deliver_now
	 end
  end

end
