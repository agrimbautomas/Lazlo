class AddVisibleFieltToOrderStatus < ActiveRecord::Migration
  def change
	 add_column :order_statuses, :visible, :boolean, :default => true
	 add_column :products, :visible, :boolean, :default => true
  end
end
