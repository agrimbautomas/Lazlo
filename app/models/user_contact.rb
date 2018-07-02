# == Schema Information
#
# Table name: user_contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  message    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserContact < ApplicationRecord
  validates :email, presence: true, uniqueness: true
end
