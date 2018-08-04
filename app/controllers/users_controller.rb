class UsersController < ApplicationController
	include ApplicationHelper

	before_action :authenticate_user!

	def profile
		@statuses = Order.cart_order_statuses
	end

end