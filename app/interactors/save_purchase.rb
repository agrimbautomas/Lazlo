# Create and save purchase data
class SavePurchase

  def self.for user, purchase_params
	 @user = user
	 @purchase_params = purchase_params

	 create_order
	 send_success_email
  end

  def self.create_order
	 @order = Order.create(
		  :user => @user,
		  :order_products_list => order_products_list,
		  :payment => payment,
		  :title => title,
		  :payment_type => Order.payment_types[:mercado_pago],
		  :order_status => OrderStatus.find_or_create_by(name: @purchase_params['collection_status']),
		  :detail => I18n.t('checkout_web_product_detail')
	 )
	 checkout
  end

  def self.checkout
	 create_mercado_pago_order
	 @order.save!
	 @user.checkout_list.product_rows.destroy_all
  end

  private

  def self.create_mercado_pago_order
	 @order.create_mercado_pago_purchase(
		  :status => @purchase_params['collection_status'],
		  :preference_id => @purchase_params['preference_id'],
		  :collection_id => @purchase_params['collection_id'],
		  :payment_type => @purchase_params['payment_type'],
	 )
  end

  def self.preferences
	 @preferences = @preferences || $mp_client.get_preference(@purchase_params['preference_id'])
  end

  def self.additional_info
	 JSON.parse(preferences['response']['additional_info']) || nil
  end

  def self.send_success_email
	 BackgroundJob.run_block do
		params = @purchase_params
		params[:order] = @order
		params[:user] = @user

		UserMailer.purchase_product_user_email(params).deliver_now
		AdminMailer.purchase_product_admin_email(params).deliver_now
	 end
  end

end
