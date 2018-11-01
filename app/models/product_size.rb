# == Schema Information
#
# Table name: product_sizes
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  price      :float(24)        not null
#  product_id :bigint(8)
#
# Indexes
#
#  index_product_sizes_on_product_id  (product_id)
#

class ProductSize < ApplicationRecord
	belongs_to :product

	validates_presence_of :name, :price, :product

	validates_numericality_of :price, greater_than_or_equal_to: 0

	validates :name, allow_blank: false, length: { maximum: 255 },
		:uniqueness => { :case_sensitive => false, scope: :product }

end
