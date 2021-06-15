class EditSiteConfigsColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :site_configs, :page_id
    drop_table :pages
  end
end
