class WishList < ActiveRecord::Base
  belongs_to :user
  has_one :product_list

end
