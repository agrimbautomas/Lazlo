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

class ProductRow < ApplicationRecord

  belongs_to :product

  validates_presence_of :product, :quantity
  validates_numericality_of :quantity, greater_than: 0

  def total
    quantity * product.price
  end


end
