class UsersController < ApplicationController
	include ApplicationHelper

	before_action :authenticate_user!

	def profile
		# Remove cancelled from list for view
		@statuses = Order.statuses.first Order.statuses.size - 1
	end

end