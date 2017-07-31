# == Schema Information
#
# Table name: favourites_lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FavouritesList < ActiveRecord::Base

  belongs_to :user

  has_many :product_rows, :dependent => :destroy


  #def save_product_row product
    #product_row = ProductRow.create(:product => product)
    #self.product_rows << product_row
    #self.save!
  #end


end
