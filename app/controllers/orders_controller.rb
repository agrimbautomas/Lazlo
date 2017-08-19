class OrdersController < ApplicationController

  def tracking
    @order = Order.find_by_code params[:tracking_code]
    @status = OrderStatus.find(@order.order_status)
    @statuses = OrderStatus.order(:priority).all
  end

end
