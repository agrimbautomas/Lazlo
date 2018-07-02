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
#  deleted_at :datetime
#
# Indexes
#
#  index_buyers_on_deleted_at  (deleted_at)
#

class Buyer < ApplicationRecord
  acts_as_paranoid

  has_many :orders

  validates :name, presence: true, allow_blank: false,
            :uniqueness => {:case_sensitive => false}, length: {maximum: 255}
end
