class AddBuyersCategory < ActiveRecord::Migration[5.1]
	def change
		add_column :buyers, :category, :integer, null: false, default: 1
	end
end
