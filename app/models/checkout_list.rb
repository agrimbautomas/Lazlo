class CheckoutList < ActiveRecord::Base

  belongs_to :user

  has_many :product_rows, :dependent => :destroy


  def save_product_row product
    product_row = ProductRow.create(:product => product)

    product_rows << product_row
    save!
  end

end
