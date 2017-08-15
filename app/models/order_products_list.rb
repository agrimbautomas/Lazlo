class OrderProductsList < ActiveRecord::Base
  belongs_to :order
  has_many :product_rows
end
