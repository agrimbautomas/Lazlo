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
#  category   :integer          default("architect_decorator"), not null
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

	enum category: { final_costumer: 0, architect_decorator: 1, business: 2 }

	def self.human_enum_name(enum_name, enum_value)
		I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}")
	end
end
