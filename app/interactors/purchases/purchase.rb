class Purchase < Interactor

  def initialize(arguments)
	 super
	 @user = arguments.fetch :user
	 @mercado_pago_params = arguments.fetch :mercado_pago_params
  end

  def cart_checkout
	 order_products_list = OrderProductsList.create_from_list(@user.checkout_list)
	 create_order(additional_info['title'], order_products_list, order_status)
  end

  def single_checkout
	 product = Product.find(product_data['id'])
	 order_products_list = OrderProductsList.create_from_product(product)
	 create_order(product_data['name'], order_products_list, order_status)
  end

  def create_order title, products_list, order_status
	 @order = Order.create(
		  :user => @user,
		  :order_products_list => products_list,
		  :payment => products_list.total,
		  :title => title,
		  :payment_type => Order.payment_types[:mercado_pago],
		  :order_status => order_status,
		  :detail => order_detail
	 )
	 checkout_callback
	 send_response_emails
  end

  def checkout_callback
	 @order.create_mercado_pago_order_from_params @mercado_pago_params
	 @user.checkout_list.product_rows.destroy_all
  end

  private

  def send_response_emails
	 BackgroundJob.run_block do
		params = @mercado_pago_params
		params[:order] = @order
		params[:user] = @user

		send_purchase_emails params
	 end
  end

  def preferences
	 @preferences = @preferences || $mp_client.get_preference(@mercado_pago_params['preference_id'])
  end

  def additional_info
	 JSON.parse(preferences['response']['additional_info']) || nil
  end

  def product_data
	 JSON.parse(additional_info['product']) || nil
  end

  def order_detail
	 I18n.t('checkout_web_product_detail')
  end

end
