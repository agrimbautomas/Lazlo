class AddProductToSiteConfig < ActiveRecord::Migration[5.1]
	def change
		add_reference :site_configs, :product, index: true
	end
end
