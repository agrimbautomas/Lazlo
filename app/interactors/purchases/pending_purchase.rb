class PendingPurchase < Purchase

  def order_status
	 order_status = OrderStatus.find_by_name('Encargado')
	 if order_status.nil?
		order_status = OrderStatus.create!(name: 'Encargado', priority: 21)
	 end
	 order_status
  end

  def send_purchase_emails params
	 AdminMailer.pending_purchase_admin_email(params).deliver_now
  end

end