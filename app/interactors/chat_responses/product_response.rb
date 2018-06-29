class ProductResponse < ChatResponseInteractor

	def self.by_name chat_params:
		get_product_response = new chat_params: chat_params

		get_product_response.identify_objects_by_name model: Product, names: chat_params[:product]
		get_product_response.existing_records_response_with_price extra_response
		get_product_response.non_existing_records_response

		get_product_response.execute
	end

	def self.extra_response
		response = ->(product) { " y podés verla en #{url_for product} " }
		response
	end

end