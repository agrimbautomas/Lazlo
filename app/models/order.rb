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
#  status                   :integer
#  title                    :string(255)
#  payment                  :integer
#  color                    :string(255)
#  mercado_pago_purchase_id :integer
#  user_id                  :integer
#  order_products_list_id   :integer
#  payment_type             :integer          default("cash"), not null
#
# Indexes
#
#  index_orders_on_buyer_id                  (buyer_id)
#  index_orders_on_mercado_pago_purchase_id  (mercado_pago_purchase_id)
#  index_orders_on_order_products_list_id    (order_products_list_id)
#  index_orders_on_product_id                (product_id)
#  index_orders_on_status                    (status)
#  index_orders_on_user_id                   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (buyer_id => buyers.id)
#  fk_rails_...  (mercado_pago_purchase_id => mercado_pago_purchases.id)
#  fk_rails_...  (order_products_list_id => order_products_lists.id)
#  fk_rails_...  (product_id => products.id)
#

class Order < ApplicationRecord

	belongs_to :buyer
	belongs_to :user
	belongs_to :mercado_pago_purchase

	has_one :order_products_list, :dependent => :destroy
	has_many :order_products_rows, through: :order_products_list

	accepts_nested_attributes_for :order_products_rows, :allow_destroy => true

	enum payment_type: [:cash, :mercado_pago]
	enum status: { requested: 0, in_blacksmith: 1, in_painting: 2,
	               finished: 3, delivered: 4, cancelled: 5 }

	before_create :set_code
	validates_presence_of :title, :payment_type, :order_products_list

	validates :title, allow_blank: false, length: { maximum: 255 }
	validates :detail, allow_blank: false, length: { maximum: 255 }
	validates :code, length: { maximum: 255 }

	validates_presence_of :user, :if => :buyer_is_nil?
	validates_presence_of :buyer, :if => :user_is_nil?

	scope :current, -> () { where.not(status: [Order.statuses[:delivered], Order.statuses[:cancelled]]) }
	scope :of, -> (user) { where(user: user) }
	scope :desc, -> () { order(:created_at => 'DESC') }

	def self.human_enum_name(enum_name, enum_value)
		I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}")
	end

	def status_str
		Order.human_enum_name(:status, status)
	end

	def self.cart_order_statuses
		statuses.first statuses.size - 1
	end

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

	def total
		order_products_list.total unless order_products_list.nil?
	end

	private

	def buyer_is_nil?
		buyer.nil?
	end

	def user_is_nil?
		user.nil?
	end


end
