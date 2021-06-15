class AddTrackingTitleToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :tracking_title, :string
  end
end
