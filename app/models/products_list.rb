class ProductsList < ActiveRecord::Base

  has_many :product_rows, :dependent => :destroy
  belongs_to :user

  validates :category, presence: true

  enum category: {I18n.t('favourites') => 1, I18n.t('checkout') => 2, I18n.t('purchased') => 3}

  def save_product_row product
    product_row = ProductRow.create(:product => product)

    self.product_rows << product_row
    self.save!
  end


end
