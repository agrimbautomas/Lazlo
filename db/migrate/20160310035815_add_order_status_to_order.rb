class AddOrderStatusToOrder < ActiveRecord::Migration[4.2]
  def change
    add_reference :orders, :order_status, index: true, foreign_key: true
  end
end
