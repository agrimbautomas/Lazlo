class AddCheckoutListToOrder < ActiveRecord::Migration[4.2]
  def change
	 add_reference :orders, :purchased_list, index: true, null: true
  end
end
