class CreateProductSizes < ActiveRecord::Migration[5.1]
	def change
		create_table :product_sizes do |t|
			t.string :name, null: false
			t.references :product, index: true
		end

	end
end
