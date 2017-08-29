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
  has_many :order_products_rows, through: :order_products_list
  belongs_to :order_status


  accepts_nested_attributes_for :order_products_list, :allow_destroy => true
  accepts_nested_attributes_for :order_products_rows, :allow_destroy => true

  enum payment_type: [:cash, :mercado_pago]

  before_create :set_code
  validates :order_products_list, presence: true

  def set_code
	 code = (0...8).map { (65 + rand(26)).chr }.join
	 if Order.find_by(code: code).blank?
		self.code = code
	 else
		self.set_code
	 end
  end

  def create_mercado_pago_order_from_params mercado_pago_params
	 create_mercado_pago_purchase(
		  :status => mercado_pago_params['collection_status'],
		  :preference_id => mercado_pago_params['preference_id'],
		  :collection_id => mercado_pago_params['collection_id'],
		  :payment_type => mercado_pago_params['payment_type'],
	 )
	 save!
  end

end
