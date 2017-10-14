class PendingPurchase < Purchase

  def order_status
	 OrderStatus.find_or_create_by(name: 'Encargado', priority: 21)
  end

  def send_purchase_emails params
	 AdminMailer.pending_purchase_admin_email(params).deliver_now
  end

end