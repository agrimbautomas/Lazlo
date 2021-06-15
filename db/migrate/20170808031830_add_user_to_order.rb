class AddUserToOrder < ActiveRecord::Migration[4.2]
  def change
	 add_reference :orders, :user, index: true, null: true
  end
end
