# == Schema Information
#
# Table name: product_prices
#
#  id              :bigint(8)        not null, primary key
#  price           :float(24)        not null
#  product_id      :bigint(8)
#  product_size_id :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_product_prices_on_product_id       (product_id)
#  index_product_prices_on_product_size_id  (product_size_id)
#

class ProductPrice < ApplicationRecord

	belongs_to :product
	belongs_to :product_size

	validates :product, presence: true
	validates :product_size, presence: true

	validates_presence_of :price
	validates_numericality_of :price, greater_than_or_equal_to: 0

end
