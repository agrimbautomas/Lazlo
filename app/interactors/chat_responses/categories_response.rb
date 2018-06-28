class CategoriesResponse < ChatResponseInteractor

	def initialize(arguments)
		super(arguments)
		self.pluralize = true
	end

	def self.show_all
		get_categories_response = new chat_params: nil
		@@response[:fulfillmentText] = "Tenemos #{Category.all.map(&:name).join(', ').downcase}. Que estabas buscando?"
		get_categories_response.execute
	end


	def self.by_name chat_params: chat_params
		get_category_response = new chat_params: chat_params

		get_category_response.identify_objects_by_name model: Category, names: [chat_params[:product_category]]
		get_category_response.existing_records_response extra_response
		get_category_response.non_existing_records_response

		get_category_response.execute
	end


	def self.extra_response
		response = ->(category) { " y podés ver los productos en #{url_for category} " }
		response
	end

end