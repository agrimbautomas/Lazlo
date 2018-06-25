class CategoriesResponse < ChatResponseInteractor

	def self.show_all
		get_categories_response = new chat_params: nil
		@@response[:fulfillmentText] = "Tenemos #{Category.all.map(&:name).join(', ').downcase}. Que estabas buscando?"
		get_categories_response.execute
	end

end