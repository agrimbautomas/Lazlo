# == Schema Information
#
# Table name: favourites
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_favourites_on_product_id  (product_id)
#  index_favourites_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#

class Favourite < ApplicationRecord
	belongs_to :user
	belongs_to :product

	validates :user, presence: true
	validates :product, presence: true

	scope :count_for, -> (product) { where(product: product).count }

end
