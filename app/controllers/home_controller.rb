class HomeController < ApplicationController

	def index
		@most_liked_product = SiteConfig.most_liked_product.present? ? SiteConfig.most_liked_product.first.product : Product.most_liked
		@most_purchased_product = Product.order('RAND()').first
	end

end
