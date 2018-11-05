# == Schema Information
#
# Table name: product_rows
#
#  id               :integer          not null, primary key
#  quantity         :integer          default(1)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :integer
#  products_list_id :integer
#
# Indexes
#
#  fk_rails_cf1216850a                     (product_id)
#  index_product_rows_on_products_list_id  (products_list_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (products_list_id => products_lists.id)
#

class ProductRow < ApplicationRecord

	belongs_to :product

	validates_presence_of :product, :quantity
	validates_numericality_of :quantity, greater_than: 0
	validates :product, :uniqueness => { scope: :quantity }

	def total
		quantity * product.price
	end

end