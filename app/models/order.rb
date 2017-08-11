# == Schema Information
#
# Table name: orders
#
#  id                       :integer          not null, primary key
#  buyer_id                 :integer
#  product_id               :integer
#  code                     :string
#  detail                   :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  order_status_id          :integer
#  tracking_title           :string
#  payment                  :integer
#  color                    :string
#  mercado_pago_purchase_id :integer
#  purchased_list_id        :integer
#  user_id                  :integer
#

class Order < ActiveRecord::Base

  belongs_to :buyer
  belongs_to :user
  belongs_to :product
  has_one :mercado_pago_purchase
  has_one :purchase_list

  before_create :set_code

  validates :buyer, presence: true
  validates :product, presence: true

  def set_code
	 code = (0...8).map {(65 + rand(26)).chr}.join
	 if Order.find_by(code: code).blank?
		self.code = code
	 else
		self.set_code
	 end
  end

end
