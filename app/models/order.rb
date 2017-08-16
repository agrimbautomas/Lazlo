# == Schema Information
#
# Table name: orders
#
#  id                       :integer          not null, primary key
#  buyer_id                 :integer
#  product_id               :integer
#  code                     :string(255)
#  detail                   :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  order_status_id          :integer
#  title                    :string(255)
#  payment                  :integer
#  color                    :string(255)
#  mercado_pago_purchase_id :integer
#  user_id                  :integer
#  products_list_id         :integer
#

class Order < ActiveRecord::Base

  belongs_to :buyer
  belongs_to :user
  belongs_to :mercado_pago_purchase
  belongs_to :products_list

  before_create :set_code

  # Todo validate if, or validate by type
  #validates :buyer, presence: true
  validates :products_list, presence: true

  def set_code
	 code = (0...8).map {(65 + rand(26)).chr}.join
	 if Order.find_by(code: code).blank?
		self.code = code
	 else
		self.set_code
	 end
  end

  def for_single product:

  end



end
