require 'rails_helper'

RSpec.describe ProductSize, type: :model do

  it { should respond_to (:name) }
  it { should validate_presence_of (:name) }
  it { should allow_value(false).for(:name) }
  it { should validate_length_of(:name).is_at_most(255) }

  it { should respond_to(:product) }
  it { should belong_to(:product) }

end
