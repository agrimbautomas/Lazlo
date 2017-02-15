class ProductRow < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_list

end
