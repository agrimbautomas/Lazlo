class AddAttachmentPictureToPageImages < ActiveRecord::Migration
  def self.up
    change_table :page_images do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :page_images, :picture
  end
end
