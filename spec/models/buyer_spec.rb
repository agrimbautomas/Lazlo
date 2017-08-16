# == Schema Information
#
# Table name: buyers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  phone      :string(255)
#  address    :string(255)
#

require 'rails_helper'

RSpec.describe Buyer, type: :model do

  it { should respond_to (:orders) }
  it { should respond_to (:name) }

  it { should have_many(:orders) }

  it { should validate_presence_of(:name) }
end
