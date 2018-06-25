class MarvelsResponse < ChatResponseInteractor

	def self.show_all
		get_marvels_response = new chat_params: nil
		@@response[:fulfillmentText] = "Trabajamos #{Marvel.all.map(&:name).join(', ').downcase}. Que estabas buscando?"
		get_marvels_response.execute
	end

	def self.by_name(chat_params:)
		get_marvels_response = new chat_params: chat_params

		identify_objects_by_name model: Marvel, names: chat_params[:material]

		@@response[:fulfillmentText] = existing_records_response @exisitng_records, extra_response
		@@response[:fulfillmentText] += non_existing_records_response @non_existing_records_names

		get_marvels_response.execute
	end

	def self.extra_response
		response = ->(object) { ' m2' }
		response
	end

end