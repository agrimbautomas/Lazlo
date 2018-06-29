class MarvelsResponse < ChatResponseInteractor

	def self.show_all
		get_marvels_response = new chat_params: nil
		get_marvels_response.response = "Trabajamos #{Marvel.all.map(&:name).join(', ').downcase}. Que estabas buscando?"
		get_marvels_response.execute
	end

	def self.by_name(chat_params:)
		get_marvels_response = new chat_params: chat_params

		get_marvels_response.identify_objects_by_name model: Marvel, names: chat_params[:material]
		get_marvels_response.existing_records_response_with_price extra_response
		get_marvels_response.non_existing_records_response

		get_marvels_response.execute

	end

	def self.extra_response
		response = ->(object) { ' m2' }
		response
	end

end