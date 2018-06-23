class Api::V1::ChatController < Api::V1::ApiController
	include ErrorRaiser

	before_action :authenticate_user!, except: [:default_response]

	def default_response
		render_categories_response Category.all
	end

	private

	def render_categories_response(categories)
		render_successful_response(
			categories,
			CategorySerializer
		)
	end

end