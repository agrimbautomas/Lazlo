class SavePurchase
  class InvalidPaymentMethod < MacainError
	 def initialize
		super "invalid_payment_method", "The payment method is invalid"
	 end
  end

  class InvalidAmount < MacainError
	 def initialize
		super "invalid_amount", "The amount to pay is invalid"
	 end
  end

  def self.for user, purchase_params
	 @user = user
	 @purchase_params = purchase_params

	 create_mercado_pago_purchase
	 create_order

	 send_success_email
  end

  private

  def self.create_order
	 byebug
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


  def self.create_mercado_pago_purchase

	 @mercado_pago_purchase = MercadoPagoPurchase.create!(
		  :user => @user,
		  :products_list => @user.checkout_list,
		  :status => MercadoPagoPurchase.statuses[:initial],
		  :title => preferences['title']
	 )
	 @mercado_pago_purchase.update_by_mp_response(@purchase_params)
  end

  private
  def self.preferences
	 @preferences = @preferences || $mp_client.get_preference(@purchase_params['preference_id'])
	 JSON.parse(@preferences['response']['additional_info']) || nil
  end

  def self.send_success_email
	 params = @purchase_params
	 params[:order] = @order
	 params[:user] = @user

	 UserMailer.purchase_product_user_email(params).deliver_now
	 AdminMailer.purchase_product_admin_email(params).deliver_now
  end

end