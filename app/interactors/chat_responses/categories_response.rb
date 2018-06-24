class CategoriesResponse < ChatResponseInteractor

	def self.with( chat_params: )
		get_categories_response = new chat_params: chat_params
		get_categories_response.execute
	end

	def execute
		@response[:fulfillmentText] = "Tenemos #{Category.all.map(&:name).join(', ')}. Que estabas buscando?"
		@response
	end

end