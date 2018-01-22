class LazloError < StandardError
	attr_reader :error
	attr_reader :error_message

	def initialize error, error_message
		@error = error
		@error_message = error_message
	end
end
