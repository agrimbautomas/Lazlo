class AddPaymentTypeToOrder < ActiveRecord::Migration
  def change
	 add_column :orders, :payment_type, :integer, null: false, default: 0
  end
end
