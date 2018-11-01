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

	validates :product, presence: true

	validates :name, presence: true, allow_blank: false,
		:uniqueness => { :case_sensitive => false }, length: { maximum: 255 }

end
