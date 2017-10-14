class SuccessPurchase < Purchase

  def order_status
	 order_status = OrderStatus.find_by_name('Encargado')
	 if order_status.nil?
		order_status = OrderStatus.create!(name: 'Encargado', priority: 21)
	 end
	 order_status
  end

  def send_purchase_emails params
	 UserMailer.success_purchase_user_email(params).deliver_now
	 AdminMailer.success_purchase_admin_email(params).deliver_now
  end

end

