class AddPriorityToOrderStatuses < ActiveRecord::Migration[4.2]
  def change
    add_column :order_statuses, :priority, :integer, :index => true
  end
end
