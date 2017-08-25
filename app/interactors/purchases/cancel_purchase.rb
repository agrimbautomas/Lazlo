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

  def self.send_response_email
	 BackgroundJob.run_block do
		params = @purchase_params
		params[:order] = @order
		params[:user] = @user

		AdminMailer.cancelled_purchase_admin_email(params).deliver_now
	 end
  end

end
