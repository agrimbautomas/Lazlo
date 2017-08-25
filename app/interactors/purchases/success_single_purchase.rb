class SuccessSinglePurchase < SuccessPurchase

  def self.order_products_list
	 product = Product.find(product_data['id'])
	 @order_products_list = OrderProductsList.create_from_product(product)
  end

  def self.payment
	 @order_products_list.total
  end

  def self.title
	 product_data['name']
  end

  def self.product_data
	 JSON.parse(additional_info['product']) || nil
  end
end
