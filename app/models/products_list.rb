class ProductsList < ActiveRecord::Base

  has_many :product_rows, :dependent => :destroy
  belongs_to :user

  validates :type, presence: true

  enum type: {I18n.t('favourites') => 1, I18n.t('history') => 2}

  def save_product_row product
    product_row = ProductRow.create(:product => product)

    self.product_rows << product_row
    self.save!
  end


end
