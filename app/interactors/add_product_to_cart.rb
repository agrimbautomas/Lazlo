class AddProductToCart < Interactor
	validates :user, :product, presence: true

	class << self
		def with user:, product:, quantity:
			add_product_to_cart = new user: user, product: product, quantity: quantity
			add_product_to_cart.execute
		end
	end

	def initialize user:, product:, quantity:
		@user = user
		@product = product
		@quantity = quantity
	end

	def execute
		validate_product
		add_to_cart
		@product
	end

	protected

	def add_to_cart
		@user.checkout_list = CheckoutList.create(:user => self) unless @user.checkout_list.present?
		@user.checkout_list.save_product_row @product, @quantity
		@user.save!
	end

	def validate_product
		invalid :product,
			'The product is already in the cart' if product_exist?
	end

	def product_exist?
		Favourite.where(product: @product).first.present?
	end
end
