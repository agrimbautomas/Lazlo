class Purchase

  def self.for user, purchase_params
	 @user = user
	 @purchase_params = purchase_params

	 create_order
	 send_response_email
  end

  def self.checkout
	 create_mercado_pago_order
	 @order.save!
  end

  def self.preferences
	 @preferences = @preferences || $mp_client.get_preference(@purchase_params['preference_id'])
  end

  def self.additional_info
	 JSON.parse(preferences['response']['additional_info']) || nil
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

  def self.order_detail
	 I18n.t('checkout_web_product_detail')
  end

end
