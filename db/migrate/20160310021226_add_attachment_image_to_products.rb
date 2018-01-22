class AddAttachmentImageToProducts < ActiveRecord::Migration[4.2]
  def self.up
    change_table :products do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :products, :image
  end
end
