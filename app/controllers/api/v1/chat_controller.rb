class Api::V1::ChatController < Api::V1::ApiController
	include ErrorRaiser

	before_action :authenticate_user!, except: [:default_response]

	def default_response

		if params[:queryResult].present?
			action = params[:queryResult][:action]
			case action
				when 'get_categories'
					get_categories

				else
					render_failed_response
			end

		end

	end

	private

	def get_categories
		response = Hash.new
		response[:fulfillmentText] = 'Alguna respuesta para lazlo'
		response[:source] = Settings.urls.base

		render json: response
	end

	def render_categories_response(categories)
		render_successful_response(
			categories,
			CategorySerializer
		)
	end

end