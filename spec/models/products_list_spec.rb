require 'rails_helper'

RSpec.describe ProductsList, type: :model do

  it { should respond_to (:user) }
  it { should respond_to (:product_rows) }
  it { should respond_to (:category) }

  it { should have_many(:product_rows) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:category) }

end
