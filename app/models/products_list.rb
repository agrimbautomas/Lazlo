# == Schema Information
#
# Table name: products_lists
#
#  id         :integer          not null, primary key
#  type       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductsList < ActiveRecord::Base

  belongs_to :user
  belongs_to :order
  has_many :product_rows, :dependent => :destroy

  def save_product_row product
	 product_rows << ProductRow.create(:product => product)
	 save!
  end

end