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
  it { should have_many(:orders) }

  it { should respond_to (:name) }
  it { should validate_presence_of (:name) }
  it { should allow_value(false).for(:name) }
  it { should validate_length_of(:name).is_at_most(255) }
  it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }

  describe '#create!' do
    let(:valid_buyer) { create(:buyer) }

    context 'with correct params' do
      it { expect(valid_buyer).to be_valid }
    end

  end

end
