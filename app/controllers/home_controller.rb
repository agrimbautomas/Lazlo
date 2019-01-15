class HomeController < ApplicationController

	def index
		@most_liked_product = Product.most_viewed
		@most_purchased_product = Product.order('RAND()').first
	end

end
