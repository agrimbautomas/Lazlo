class Api::V1::ChatController < Api::V1::ApiController
	include ErrorRaiser

	before_action :authenticate_user!, except: [:default_response]

	def default_response

		if params[:queryResult].present?
			action = params[:queryResult][:action]
			parameters = params[:queryResult][:parameters]
			case action
				when 'get_categories'
					render json: CategoriesResponse.with(chat_params: parameters)
				when 'get_marvels'
					render json: CategoriesResponse.with(chat_params: parameters)
				else
					render_failed_response
			end

		end

	end

end