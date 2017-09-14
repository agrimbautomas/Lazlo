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
  belongs_to :order_status

  has_one :order_products_list, :dependent => :destroy
  has_many :order_products_rows, through: :order_products_list

  accepts_nested_attributes_for :order_products_rows, :allow_destroy => true

  enum payment_type: [:cash, :mercado_pago]

  before_create :set_code
  validates_presence_of :title, :payment_type, :order_products_list

  validates :title, allow_blank: false, length: { maximum: 255 }
  validates :detail, allow_blank: false, length: { maximum: 255 }
  validates :code, length: { maximum: 255 }

  validates_presence_of :user, :if => :buyer_is_nil?
  validates_presence_of :buyer, :if => :user_is_nil?

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

  def tracking_link
	 Rails.application.routes.url_helpers.tracking_order_by_code_url(code)
  end

  private

  def buyer_is_nil?
	 buyer.nil?
  end

  def user_is_nil?
	 user.nil?
  end


end
