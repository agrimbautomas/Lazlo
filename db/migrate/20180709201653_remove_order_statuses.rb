class RemoveOrderStatuses < ActiveRecord::Migration[5.1]
	def change
		

		if index_exists? :orders, :order_status
			remove_index :orders, :order_status
		end

		if foreign_key_exists? :orders, :order_statuses
			remove_foreign_key :orders, :order_statuses
		end

		if column_exists? :orders, :order_status_id
			rename_column :orders, :order_status_id, :status
		end

		drop_table :order_statuses
	end
end
