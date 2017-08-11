# == Schema Information
#
# Table name: buyers
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  phone      :string
#  address    :string
#

require 'rails_helper'

RSpec.describe Buyer, type: :model do

  it { should respond_to (:orders) }
  it { should respond_to (:name) }

  it { should have_many(:orders) }

  it { should validate_presence_of(:name) }
end
