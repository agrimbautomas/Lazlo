class AddConfigType < ActiveRecord::Migration[5.1]
  def change
    add_column :site_configs, :config_type, :integer, null: false
  end
end
