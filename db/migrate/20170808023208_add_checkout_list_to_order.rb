class AddCheckoutListToOrder < ActiveRecord::Migration
  def change
	 add_reference :orders, :checkout_list, index: true, null: true
	 add_column :checkout_lists, :sold, :boolean, default: false
  end
end
