class ChatResponseInteractor < Interactor
	attr_reader :response

	def initialize(arguments)
		super(arguments)
		@@response = Hash.new
		@@response[:source] = Settings.urls.base
	end

end