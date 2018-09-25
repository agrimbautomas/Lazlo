require 'rails_helper'

RSpec.describe Buyer, type: :model do

	it { should respond_to (:orders) }
	it { should have_many(:orders) }

	it { should respond_to (:name) }
	it { should validate_presence_of (:name) }
	it { should allow_value(false).for(:name) }
	it { should validate_length_of(:name).is_at_most(255) }
	it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }

	it { should respond_to (:category) }
	it { should validate_presence_of (:category) }

	it { expect define_enum_for(:category).with [:market, :architect] }

	describe '#create!' do
		let(:valid_buyer) { create(:buyer) }

		context 'with correct params' do
			it { expect(valid_buyer).to be_valid }
		end

	end

end
