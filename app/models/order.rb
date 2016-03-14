class Order < ActiveRecord::Base
  belongs_to :buyer
  belongs_to :product

  before_create :set_code

  validates :buyer, presence: true
  validates :product, presence: true

  def set_code
    code = (0...8).map { (65 + rand(26)).chr }.join
    if Order.find_by(code: code).blank?
      self.code = code
    else
      self.set_code
    end
  end

end
