class AddPriorityToOrderStatuses < ActiveRecord::Migration
  def change
    add_column :order_statuses, :priority, :integer, :index => true
  end
end
