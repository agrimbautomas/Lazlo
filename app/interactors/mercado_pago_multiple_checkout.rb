class MercadoPagoMultipleCheckout < MercadoPagoCheckout
  include Rails.application.routes.url_helpers

  attr_accessor :link

  def initialize(arguments)
	 super
	 @parameters = arguments.fetch :parameters
	 @user = @parameters['user']
  end

  def checkout
	 @product_rows = @user.checkout_list.product_rows
	 payment_link cart_checkout_preference_data
  end

  private

  def back_urls_json
	 product_row = @product_rows.first
	 {
		  'pending' => product_purchase_success_url(product_row.product),
		  'success' => product_purchase_pending_url(product_row.product),
		  'failure' => product_purchase_failure_url(product_row.product)
	 }
  end


end