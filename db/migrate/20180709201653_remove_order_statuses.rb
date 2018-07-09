class RemoveOrderStatuses < ActiveRecord::Migration[5.1]
	def change

		if index_exists? :orders, :order_status
			remove_index :orders, :order_status
		end

		if foreign_key_exists? :orders, :order_statuses
			remove_foreign_key :orders, :order_statuses
		end

		# Migrate form OrderStatus relation to Order.status
		Order.find_each do |order|
			case order.order_status_id
				when 1, 7
					status = 0
				when 2
					status = 1
				when 3
					status = 2
				when 4
					status = 3
				when 5
					status = 4
				else
					status = 5
			end
			order.update_attribute(:order_status_id, status)
		end

		if column_exists? :orders, :order_status_id
			rename_column :orders, :order_status_id, :status
		end


		drop_table :order_statuses
	end
end
