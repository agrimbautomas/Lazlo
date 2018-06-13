class UsersController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!

  def profile

    @statuses = OrderStatus.visible.order(:priority)
    @current_purchased_orders =  current_user.current_orders
    @order = @current_purchased_orders.first

  end

end