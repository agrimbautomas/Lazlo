class AddPaymentTypeToOrder < ActiveRecord::Migration[4.2]
  def change
	 add_column :orders, :payment_type, :integer, null: false, default: 0
  end
end
