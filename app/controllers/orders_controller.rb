class OrdersController < ApplicationController

  def tracking
    @order = Order.find_by_code params[:tracking_code]
    @statuses = OrderStatus.visible.order(:priority)
  end

end
