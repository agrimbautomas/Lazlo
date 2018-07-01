class Api::V1::CartController < Api::V1::ApiController

	before_action :set_product

	def add_product
		byebug
		#current_user.add_product_to_cart @product
		render json: { :response => 'success' }
	end

	def remove_cart_product_row
		#current_user.checkout_list.product_rows.find_by(:product => params[:product_id]).destroy
		render json: { :response => 'success' }
	end

	private
	def set_product
		@product = Product.friendly.find(params[:product_id])
	end

end