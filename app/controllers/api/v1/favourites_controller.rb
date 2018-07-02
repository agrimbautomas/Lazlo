class Api::V1::FavouritesController < Api::V1::ApiController

	def create
		favourite = CreateFavourite.with(
			user: current_user,
			product: Product.find(params[:product_id])
		)
		render_products_response favourite.product
	end

	def destroy
		DeleteFavourite.with product: Product.find(params[:product_id])
		render_successful_empty_response
	end

end