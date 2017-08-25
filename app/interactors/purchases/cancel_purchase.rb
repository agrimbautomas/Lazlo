class CancelPurchase < Purchase

  def order_status
	 OrderStatus.find_or_create_by(name: 'Cancelado')
  end

  def checkout_callback
  end

  def send_purchase_emails params
	 AdminMailer.cancelled_purchase_admin_email(params).deliver_now
  end

end
