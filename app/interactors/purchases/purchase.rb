class Purchase < Interactor

  def initialize(arguments)
	 super
	 @user = arguments.fetch :user
	 @mercado_pago_params = arguments.fetch :mercado_pago_params
  end

  def checkout
	 create_mercado_pago_order
	 @order.save!
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

  private

  def create_mercado_pago_order
	 @order.create_mercado_pago_purchase(
		  :status => @mercado_pago_params['collection_status'],
		  :preference_id => @mercado_pago_params['preference_id'],
		  :collection_id => @mercado_pago_params['collection_id'],
		  :payment_type => @mercado_pago_params['payment_type'],
	 )
  end

  def order_detail
	 I18n.t('checkout_web_product_detail')
  end

end
