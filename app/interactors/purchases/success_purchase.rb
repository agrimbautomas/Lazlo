class SuccessPurchase < Purchase

  def order_status
	 OrderStatus.find_or_create_by(name: 'Encargado')
  end

  private

  def send_response_email
	 BackgroundJob.run_block do
		params = @mercado_pago_params
		params[:order] = @order
		params[:user] = @user

		UserMailer.success_purchase_user_email(params).deliver_now
		AdminMailer.success_purchase_admin_email(params).deliver_now
	 end
  end

end

