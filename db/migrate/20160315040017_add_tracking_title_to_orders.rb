class AddTrackingTitleToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :tracking_title, :string
  end
end
