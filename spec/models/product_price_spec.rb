require 'rails_helper'

RSpec.describe ProductPrice, type: :model do

  it { should respond_to (:price) }
  it { should validate_presence_of (:price) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

  it { should respond_to(:product) }
  it { should belong_to(:product) }

  it { should respond_to(:product_size) }
  it { should belong_to(:product_size) }

end
