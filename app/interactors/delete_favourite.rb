class DeleteFavourite < Interactor
	validates :product, presence: true

	def self.with( product: )
		create_favourite = new product: product
		create_favourite.execute
	end

	def execute
		favourite = Favourite.find_by product: product
		validate_favourite favourite
		favourite.destroy!
	end

	protected

	def validate_favourite( favourite )
		invalid :product, 'The product has not been marked as a favourite' if favourite.nil?
	end
end
