class SuccessPurchase < Purchase

  def order_status
	  Order.statuses[:requested]
  end

  def send_purchase_emails params
	 UserMailer.success_purchase_user_email(params).deliver_now
	 AdminMailer.success_purchase_admin_email(params).deliver_now
  end

end

