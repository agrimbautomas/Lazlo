class RenamePageImagesToSiteConfig < ActiveRecord::Migration[5.1]
  def change
    rename_table :page_images, :site_configs
  end

  def self.down
    remove_column :page_images, :page_id
  end

end
