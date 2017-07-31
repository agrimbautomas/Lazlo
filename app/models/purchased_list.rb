# == Schema Information
#
# Table name: purchased_lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PurchasedList < ActiveRecord::Base


end
