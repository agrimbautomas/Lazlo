class AddAttachmentImageToOrderStatuses < ActiveRecord::Migration[4.2]
  def self.up
    change_table :order_statuses do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :order_statuses, :image
  end
end
