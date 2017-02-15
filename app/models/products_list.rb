class ProductsList < ActiveRecord::Base
  has_many :product_rows
  belongs_to :user

  def save_product_row product_row
    self.product_rows << product_row
    self.save!
  end

end
