# == Schema Information
#
# Table name: buyers
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  phone      :string
#  address    :string
#

class Buyer < ApplicationRecord
  acts_as_paranoid

  has_many :orders

  validates :name, presence: true, allow_blank: false,
            :uniqueness => {:case_sensitive => false}, length: {maximum: 255}
end
