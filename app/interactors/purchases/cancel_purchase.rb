class CancelPurchase < Purchase

  def order_status
	 OrderStatus.find_or_create_by(name: 'Cancelado')
  end

  def checkout_callback
  end

  private

  def send_response_email
	 BackgroundJob.run_block do
		params = @purchase_params
		params[:order] = @order
		params[:user] = @user

		AdminMailer.cancelled_purchase_admin_email(params).deliver_now
	 end
  end

end
