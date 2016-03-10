class Order < ActiveRecord::Base
  belongs_to :buyer
  belongs_to :product


  validates :buyer, presence: true
  validates :product, presence: true

end
