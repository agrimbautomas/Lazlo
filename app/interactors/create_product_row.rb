class CreateProductRow < Interactor
	validates :checkout_list, :product, :quantity, presence: true

	class << self
		def with checkout_list:, product:, quantity:
			create_product_row = new checkout_list: checkout_list, product: product, quantity: quantity
			create_product_row.execute
		end
	end

	def execute
		validate_list
		create_product_row
	end

	protected
	def create_product_row
		if checkout_list.product_rows.exists?(:product => product)
			checkout_list.product_rows.find_by(:product => product).update_attributes(:quantity => quantity)
		else
			checkout_list.product_rows.create!(:product => product, :quantity => quantity)
		end
	end

	def validate_list
		invalid :checkout_list, 'The checkout_list must not be null' if checkout_list.nil?
	end

end
