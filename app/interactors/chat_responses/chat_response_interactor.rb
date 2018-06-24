class ChatResponseInteractor < Interactor

	def initialize(arguments)
		super(arguments)
		@response = Hash.new
		@response[:source] = Settings.urls.base
	end

end