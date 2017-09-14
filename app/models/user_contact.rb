# == Schema Information
#
# Table name: user_contacts
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserContact < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
end
