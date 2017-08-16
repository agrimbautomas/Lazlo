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

  def update_by_mp_response params
	 self.update_attributes(
		  :collection_id => params["collection_id"],
		  :preference_id => params["preference_id"],
		  :payment_type => params["payment_type"],
		  :status => params["collection_status"]
	 )
  end

  def self.create_from_preferences preferences
	 byebug
	 MercadoPagoPurchase.create!(
		  :title => preferences['title'],
		  :status => MercadoPagoPurchase.statuses[:initial],
	 )
	 @mercado_pago_purchase.update_by_mp_response(@purchase_params)
  end

end
