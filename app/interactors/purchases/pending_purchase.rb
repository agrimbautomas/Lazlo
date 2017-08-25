class PendingPurchase < Purchase

  def cart_checkout
	 order_products_list = OrderProductsList.create_from_list(@user.checkout_list)

	 create_order(additional_info['title'], order_products_list)
	 send_response_email
  end

  def single_checkout
	 product = Product.find(product_data['id'])
	 order_products_list = OrderProductsList.create_from_product(product)

	 create_order(product_data['name'], order_products_list)
	 send_response_email
  end

  def create_order title, products_list
	 @order = Order.create(
		  :user => @user,
		  :order_products_list => products_list,
		  :payment => products_list.total,
		  :title => title,
		  :payment_type => Order.payment_types[:mercado_pago],
		  :order_status => OrderStatus.find_by_name('Encargado'),
		  :detail => order_detail
	 )
	 checkout
  end

  private

  def send_response_email
	 BackgroundJob.run_block do
		params = @purchase_params
		params[:order] = @order
		params[:user] = @user

		AdminMailer.pending_purchase_admin_email(params).deliver_now
	 end
  end

end