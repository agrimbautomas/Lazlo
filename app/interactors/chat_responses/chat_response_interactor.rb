class ChatResponseInteractor < Interactor
	attr_reader :response

	def initialize(arguments)
		super(arguments)
		@@response = Hash.new
		@@response[:source] = Settings.urls.base
	end

	protected

	def self.identify_objects_by_name model:, names:
		@exisitng_records = []
		@non_existing_records_names = []
		names.each do |name|
			model_object = model.find_by("name LIKE ? ", "%#{ strip_query(name) }%")
			model_object.present? ? @exisitng_records.push(model_object) : @non_existing_records_names.push(name)
		end

	end

	def self.existing_records_response records, extra_response
		response = ''
		if records.present?
			response = "Si, tenemos. Te paso los precios: \n\n"
			records.each do |record|
				response += "#{record.name.capitalize}: #{format_price record.price}"
				response += extra_response.call record
				response += "\n\n"
			end
		end
		response
	end

	def self.non_existing_records_response names
		response = ''
		if names.present?
			response = 'Por el momento no trabajamos con '
			names.each_with_index do |name, i|
				response += i != 0 ? ' ni con ' : ''
				response += name
			end
			response += " pero mandanos un mail a hola@lazlo.la y te podemos cotizar el producto a medida"
		end
		response
	end

	private

	def self.strip_query query
		clean_query = query.lstrip.chop
		clean_query.gsub!(/[^abcdefghijklmnñopqrstuvwxyz ]/, '')
		clean_query
	end

	def self.url_for url
		Rails.application.routes.url_helpers.url_for url
	end

	def self.format_price price
		ApplicationController.helpers.format_price price
	end

end