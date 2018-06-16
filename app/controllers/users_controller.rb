class UsersController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!

  def profile

    @statuses = OrderStatus.visible.order(:priority)
    # Todo Remove limit
    @current_purchased_orders =  current_user.current_orders.limit(3)

  end

end