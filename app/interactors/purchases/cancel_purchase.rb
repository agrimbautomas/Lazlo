class CancelPurchase < Purchase

  def order_status
	 order_status = OrderStatus.find_by_name('Cancelado')
	 if order_status.nil?
		order_status = OrderStatus.create!(name: 'Cancelado', priority: 22)
	 end
	 order_status
  end

  def checkout_callback
  end

  def send_purchase_emails params
	 AdminMailer.cancelled_purchase_admin_email(params).deliver_now
  end

end
