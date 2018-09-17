class DeleteFavourite < Interactor
	validates :product, presence: true

	def self.with( user:, product: )
		create_favourite =  new user: user, product: product
		create_favourite.execute
	end

	def execute
		favourite = Favourite.find_by user: user, product: product
		validate_favourite favourite
		validate_user user
		favourite.destroy!
	end

	protected

	def validate_favourite( favourite )
		invalid :product, 'The product has not been marked as a favourite' if favourite.nil?
	end

	def validate_user( user )
		invalid :user, 'The user is not valid' if user.nil?
	end

end
