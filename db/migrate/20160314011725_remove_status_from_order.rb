class RemoveStatusFromOrder < ActiveRecord::Migration[4.2]
  def change
    remove_column :orders, :status, :string
  end
end
