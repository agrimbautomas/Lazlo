class AddAttachmentImageToProductTypes < ActiveRecord::Migration[4.2]
  def self.up
    change_table :product_types do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :categories, :image
  end
end
