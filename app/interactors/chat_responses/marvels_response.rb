class MarvelsResponse < ChatResponseInteractor

	def self.with( chat_params: )
		get_marvels_response = new chat_params: chat_params
		get_marvels_response.execute
	end

	def execute
		@response[:fulfillmentText] = "Trabajamos #{Marvel.all.map(&:name).join(', ').downcase}. Que estabas buscando?"
		@response
	end

end