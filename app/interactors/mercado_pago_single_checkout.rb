class MercadoPagoSingleCheckout < MercadoPagoCheckout
  include Rails.application.routes.url_helpers

  attr_accessor :link

  def initialize(arguments)
	 super
	 @parameters = arguments.fetch :parameters
	 @user = @parameters['user']
	 @product = @parameters['product']
	# byebug
  end

  def checkout
	 @product_rows = [ProductRow.new(product: @product, quantity: 1)]
	 payment_link cart_checkout_preference_data
  end

  private

  def back_urls_json
	 product_row = @product_rows.first
	 {
		  'pending' => single_checkout_success_url(product_row.product),
		  'success' => single_checkout_pending_url(product_row.product),
		  'failure' => single_checkout_failure_url(product_row.product)
	 }
  end


end