class AddUserToOrder < ActiveRecord::Migration
  def change
	 add_reference :orders, :user, index: true, null: true
  end
end
