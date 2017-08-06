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
  end

  private

  def self.create_mercado_pago_purchase
	 @mp_purchase = @user.mercado_pago_purchases.last
	 @mp_purchase.update_by_mp_response(@purchase_params) unless @mp_purchase.nil?
  end

  def self.create_order
	 buyer = Buyer.create!(:name => @user.email, :email => @user.email)
	 byebug
	 @order = Order.create!(:buyer => buyer,
									:product => @product,
									# Todo Change product for checkout list and save
									#:product => @product,
									:mercado_pago_purchase => @mp_purchase,
									:payment => 0,
									:tracking_title => @product[:name],
									:order_status_id => OrderStatus.find_by_priority(1).id,
									:detail => 'Producto comprado dedes la Web')
	 send_success_email
  end

  def send_success_email
	 params = purchase_params
	 params[:order] = @order
	 params[:message] = 'concretó'

	 UserMailer.purchased_product_user_notification(params).deliver_now
	 send_admin_email params
  end

  def estimation_for distance:, duration:, time_of_day:
	 travel_cost = @trip_cost_calculator.calculate distance, time_of_day
	 Estimation.new(distance, duration, travel_cost[:minimum_rate], travel_cost[:maximum_rate])
  end

  def validate_address from:, to:
	 raise InvalidFromAddress if from.nil? || from[:text].blank?
	 raise InvalidToAddress if to.blank? || to[:text].blank?
  end
end