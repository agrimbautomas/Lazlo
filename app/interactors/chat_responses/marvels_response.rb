class MarvelsResponse < ChatResponseInteractor

	def self.show_all
		get_marvels_response = new chat_params: nil
		@@response[:fulfillmentText] = "Trabajamos #{Marvel.all.map(&:name).join(', ').downcase}. Que estabas buscando?"
		get_marvels_response.execute
	end

	def self.by_name(chat_params:)
		get_marvels_response = new chat_params: chat_params

		marvel_names = chat_params['material']

		marvels_in_stock = []
		marvels_not_worked = []

		marvel_names.each do |marvel_name|
			marvel = Marvel.find_by("name LIKE ? ", "%#{marvel_name}%")
			marvel.present? ? marvels_in_stock.push(marvel) : marvels_not_worked.push(marvel_name)
		end

		@@response[:fulfillmentText] = marvels_in_stock_response marvels_in_stock
		@@response[:fulfillmentText] += marvels_not_worked_response marvels_not_worked

		get_marvels_response.execute
	end

	def execute
		@@response
	end

	private

	def self.marvels_in_stock_response marvels
		response = ''
		if marvels.present?
			response = 'Si, '
			marvels.each_with_index do |marvel, i|
				response += i != 0 ? ' y ' : 'tenemos '
				response += "#{marvel.name} a #{ApplicationController.helpers.format_price marvel.price} m2"
			end
		end
		response
	end

	def self.marvels_not_worked_response marvel_names
		response = '. '
		if marvel_names.present?

			response += 'Por el momento no trabajamos con '
			marvel_names.each_with_index do |marvel_name, i|
				response += i != 0 ? ' ni con ' : ''
				response += marvel_name
			end
		end
		response
	end

end