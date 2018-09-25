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
#  category   :integer          default(1), not null
#
# Indexes
#
#  index_buyers_on_deleted_at  (deleted_at)
#

class Buyer < ApplicationRecord
	acts_as_paranoid

	has_many :orders

	validates_presence_of :name, :category

	validates :name, allow_blank: false,
		:uniqueness => { :case_sensitive => false }, length: { maximum: 255 }

	enum category: { market: 0, architect: 1 }

end
