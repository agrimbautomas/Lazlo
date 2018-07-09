class PendingPurchase < Purchase

  def order_status
	  Order.statuses[:requested]
  end

  def send_purchase_emails params
	 AdminMailer.pending_purchase_admin_email(params).deliver_now
  end

end