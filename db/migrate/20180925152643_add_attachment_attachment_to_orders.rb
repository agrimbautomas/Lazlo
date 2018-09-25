class AddAttachmentAttachmentToOrders < ActiveRecord::Migration[5.1]
	def self.up
		change_table :orders do |t|
			t.attachment :document
		end
	end

	def self.down
		remove_attachment :orders, :document
	end
end
