class BudgetResponse < ChatResponseInteractor

	def self.for_product chat_params:
		get_budget_response = new chat_params: chat_params

		marvel = Marvel.find_by("name LIKE ? ", "%#{chat_params[:material]}%")

		if marvel.present? and marvel.price.present?
			price = get_price_per_size get_sizes(chat_params), marvel.price
			response = "El precio es de #{price} por el producto en #{marvel.name} "
			response += "en un tamaño de #{get_sizes(chat_params).join('x')}cm"
		elsif marvel.nil?
			response = "Actualemente no trabajamos con #{marvel_name}, tenés otra consulta?"
		else
			response = "Actualemente no tenemos el precio del #{marvel_name}, tenés otra consulta?"
		end

		get_budget_response.response = response
		get_budget_response.execute
	end

	private
	def self.get_price_per_size sizes, price
		size_sum = (sizes.first.to_i + sizes.second.to_i) / 2
		total_price = (size_sum / 100.0) * price
		ApplicationController.helpers.format_price total_price
	end

	def self.get_sizes chat_params
		chat_params[:product_size].scan(/\d+/)
	end

end