class Api::V1::ChatController < Api::V1::ApiController
	include ErrorRaiser

	before_action :authenticate_user!, except: [:default_response]

	def default_response

		if params[:queryResult].present?
			action = params[:queryResult][:action]
			parameters = params[:queryResult][:parameters]
			case action
				when 'get_categories'
					render json: CategoriesResponse.show_all
				when 'get_category_by_name'
					render json: CategoriesResponse.by_name(chat_params: parameters)
				when 'get_marvels'
					render json: MarvelsResponse.show_all
				when 'get_marvel_by_name'
					render json: MarvelsResponse.by_name(chat_params: parameters)
				when 'get_buget'
					render json: BudgetResponse.for_product(chat_params: parameters)
				when 'get_product'
					render json: ProductResponse.by_name(chat_params: parameters)
				else
					render_failed_response
			end

		end

	end

end