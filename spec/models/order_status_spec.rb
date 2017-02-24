require 'rails_helper'

RSpec.describe OrderStatus, type: :model do

  it { should respond_to (:name) }
  it { should respond_to (:priority) }

  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:priority) }

end
