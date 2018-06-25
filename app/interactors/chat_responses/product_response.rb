class ProductResponse < ChatResponseInteractor

	def self.by_name chat_params: chat_params
		get_product_response = new chat_params: chat_params

		identify_objects_by_name model: Product, names: chat_params[:product]
		@@response[:fulfillmentText] = existing_records_response @exisitng_records, extra_response
		@@response[:fulfillmentText] += non_existing_records_response @non_existing_records_names

		get_product_response.execute
	end

	def self.extra_response
		response = ->(product) { " y podés verla en #{url_for product} " }
		response
	end

	def execute
		@@response
	end

end