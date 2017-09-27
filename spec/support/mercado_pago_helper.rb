module MercadoPagoHelper

  def checkout_preferences user, product
	 params = ActionController::Parameters.new
	 params[:user] = user
	 params[:product] = product

	 single_checkout = MercadoPagoSingleCheckout.(parameters: params, delegate: self)
	 checkout_preference_data = single_checkout.send(:checkout_preference_data)
	 single_checkout.checkout_preferences checkout_preference_data
  end

  def checkout_preferences_from_file
	 checkout_preferences_file = File.read('spec/support/api/samples/checkout-preference.json')
	 JSON.parse(checkout_preferences_file)
  end

  def mercado_pago_params user
	 preferences = checkout_preferences_from_file

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