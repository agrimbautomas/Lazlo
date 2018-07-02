class CreateFavourite < Interactor
	validates :user, :product, presence: true

	def self.with( user: , product: )
		create_favourite = new user: user, product: product
		create_favourite.execute
	end

	def execute
		validate_product
		Favourite.create! user: user, product: product
	end

	protected

	def validate_product
		invalid :product,
			'The product has already been marked as a favourite' if favourite_exist?
	end

	def favourite_exist?
		Favourite.where( product: product ).first.present?
	end
end
