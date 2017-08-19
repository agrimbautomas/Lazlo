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
#  title                    :string
#  payment                  :integer
#  color                    :string
#  mercado_pago_purchase_id :integer
#  user_id                  :integer
#  order_products_list_id   :integer
#  payment_type             :integer          default(0), not null
#

class Order < ActiveRecord::Base

  belongs_to :buyer
  belongs_to :user
  belongs_to :mercado_pago_purchase
  belongs_to :order_products_list
  belongs_to :order_status

  enum payment_type: [:cash, :mercado_pago]

  before_create :set_code
  validates :order_products_list, presence: true

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
