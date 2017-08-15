class SaveSinglePurchase < SavePurchase

  private

  def self.create_order
	 @order = Order.create(
		  :user => @user,
		  :products_list => @user.checkout_list,
		  :mercado_pago_purchase => @mercado_pago_purchase,
		  :payment => 0,
		  :tracking_title => preferences['title'],
		  :order_status_id => OrderStatus.find_by_priority(1).id,
		  :detail => 'Producto comprado dedes la Web'
	 )
	 @user.store_checkout_list
  end

end