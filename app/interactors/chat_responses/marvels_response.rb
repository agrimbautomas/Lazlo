class MarvelsResponse < ChatResponseInteractor

	def self.show_all
		get_marvels_response = new chat_params: nil
		@@response[:fulfillmentText] = "Trabajamos #{Marvel.all.map(&:name).join(', ').downcase}. Que estabas buscando?"
		get_marvels_response.execute
	end

	def self.by_name(chat_params:)
		get_marvels_response = new chat_params: chat_params

		identify_objects_by_name model: Marvel, names: chat_params[:material]

		@@response[:fulfillmentText] = existing_records_response records @exisitng_records, 'm2'
		@@response[:fulfillmentText] += non_existing_records_response @non_existing_records_names

		get_marvels_response.execute
	end

	def execute
		@@response
	end

end