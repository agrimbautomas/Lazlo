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

class ProductRow < ActiveRecord::Base
  belongs_to :product

  def total_price
    quantity * product.price
  end
end
