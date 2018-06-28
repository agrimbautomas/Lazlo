class CategoriesResponse < ChatResponseInteractor

	def self.show_all
		get_categories_response = new chat_params: nil
		@@response[:fulfillmentText] = "Tenemos #{Category.all.map(&:name).join(', ').downcase}. Que estabas buscando?"
		get_categories_response.execute
	end


	def self.by_name chat_params: chat_params
		get_category_response = new chat_params: chat_params

		identify_objects_by_name model: Category, names: chat_params[:category]
		@@response[:fulfillmentText] = existing_records_response @exisitng_records, extra_response
		@@response[:fulfillmentText] += non_existing_records_response @non_existing_records_names

		get_category_response.execute
	end

end