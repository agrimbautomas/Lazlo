# == Schema Information
#
# Table name: buyers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  phone      :string(255)
#  address    :string(255)
#

class Buyer < ActiveRecord::Base

  has_many :orders

  validates :name, presence: true
end
