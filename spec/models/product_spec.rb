require 'rails_helper'

RSpec.describe Product, type: :model do

  it { should respond_to (:name) }
  it { should respond_to (:payment) }


  #it { should have_one(:category) }
  it { should have_many(:orders) }
  it { should have_many(:product_images) }
  it { should have_many(:product_rows) }

  it { should validate_presence_of(:name) }

  #it { should have_attached_file(:image) }

end
