class AddVisibleFieltToOrderStatus < ActiveRecord::Migration[4.2]
  def change
	 add_column :order_statuses, :visible, :boolean, :default => true
	 add_column :products, :visible, :boolean, :default => true
  end
end
