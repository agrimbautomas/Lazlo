class OrdersController < ApplicationController

  def tracking
    @order = Order.find_by_code params[:tracking_code]
	 @statuses = OrderStatus.visible.order(:priority)

	 if @order.nil?
		flash.notice = t('tracking_code_not_exists')
		redirect_to cart_path
	 end
  end

end
