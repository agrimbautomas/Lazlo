# == Schema Information
#
# Table name: mercado_pago_purchases
#
#  id            :integer          not null, primary key
#  collection_id :string(255)
#  preference_id :string(255)
#  payment_type  :string(255)
#  status        :string(255)      default("initial"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  order_id      :integer          not null
#

class MercadoPagoPurchase < ActiveRecord::Base

  belongs_to :order

  enum status: [:initial, :authorized, :paused, :cancelled, :pending]

end
