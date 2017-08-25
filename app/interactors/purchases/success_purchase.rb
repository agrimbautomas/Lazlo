class SuccessPurchase < Purchase

  def cart_checkout_for user, purchase_params
  end

  def single_checkout
	 byebug
	 create_order
	 send_response_email
  end

  def create_order
	 @order = Order.create(
		  :user => @user,
		  :order_products_list => order_products_list,
		  :payment => payment,
		  :title => title,
		  :payment_type => Order.payment_types[:mercado_pago],
		  :order_status => OrderStatus.find_by_name('Encargado'),
		  :detail => order_detail
	 )
	 create_mercado_pago_order
	 checkout
  end

  private

  def send_response_email
	 BackgroundJob.run_block do
		params = @mercado_pago_params
		params[:order] = @order
		params[:user] = @user

		UserMailer.success_purchase_user_email(params).deliver_now
		AdminMailer.success_purchase_admin_email(params).deliver_now
	 end
  end

end

class SuccessSinglePurchase < SuccessPurchase

  def order_products_list
	 product = Product.find(product_data['id'])
	 @order_products_list = OrderProductsList.create_from_product(product)
  end

  def payment
	 @order_products_list.total
  end

  def title
	 product_data['name']
  end

  def product_data
	 JSON.parse(additional_info['product']) || nil
  end
end

class SuccessCartPurchase < SuccessPurchase

  def order_products_list
	 @order_products_list = OrderProductsList.create_from_list(@user.checkout_list)
  end

  def payment
	 @order_products_list.total
  end

  def title
	 additional_info['title']
  end


end