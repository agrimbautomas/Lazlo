require 'rails_helper'

RSpec.describe Buyer, type: :model do

  it { should respond_to (:orders) }
  it { should respond_to (:name) }

  it { should have_many(:orders) }

  it { should validate_presence_of(:name) }
end
