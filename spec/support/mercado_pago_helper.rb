module MercadoPagoHelper

  def checkout_preferences user, product
	 params = ActionController::Parameters.new
	 params[:user] = user
	 params[:product] = product

	 single_checkout = MercadoPagoSingleCheckout.(parameters: params, delegate: self)
	 checkout_preference_data = single_checkout.send(:checkout_preference_data)
	 single_checkout.checkout_preferences checkout_preference_data
  end

  def mercado_pago_params user, product
	 preferences = checkout_preferences user, product
	 ActionController::Parameters.new(
		  :collection_id => "6588898",
		  :collection_status => "pending",
		  :preference_id => preferences['response']['id'],
		  :payment_type => "ticket",
		  :controller => "checkout",
		  :user => user
	 )
  end

end