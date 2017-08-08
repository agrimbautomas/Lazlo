class AddCheckoutListToOrder < ActiveRecord::Migration
  def change
	 add_reference :orders, :purchased_list, index: true, null: true
  end
end
