class OrdersController < ApplicationController

  def tracking
    order = Order.find_by_code params[:tracking_code]
    status = OrderStatus.find(order.order_status_id)
    statuses = OrderStatus.all
    @locals = { :order => order, :status => status, :statuses => statuses}
  end

end
