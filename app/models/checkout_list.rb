# == Schema Information
#
# Table name: checkout_lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CheckoutList < ActiveRecord::Base

  belongs_to :user
  belongs_to :order
  has_many :product_rows, :dependent => :destroy

end
