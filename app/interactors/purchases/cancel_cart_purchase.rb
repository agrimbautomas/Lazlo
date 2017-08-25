class CancelCartPurchase < CancelPurchase

  def self.order_products_list
	 @order_products_list = OrderProductsList.create_from_list(@user.checkout_list)
  end

  def self.payment
	 @order_products_list.total
  end

  def self.title
	 additional_info['title']
  end


end