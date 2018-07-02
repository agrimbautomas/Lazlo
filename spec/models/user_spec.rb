require 'rails_helper'

RSpec.describe User, type: :model do

  it_behaves_like 'a Paranoid model'

  it { should respond_to(:email) }
  it { should validate_presence_of(:email) }
  #it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should validate_length_of(:email).is_at_most(255) }

  it { should respond_to (:password) }
  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }

  it { should respond_to(:checkout_list) }
  it { should have_one(:checkout_list) }

  it { should respond_to(:purchased_list) }
  it { should have_one(:purchased_list) }

  it { should respond_to(:orders) }
  it { should have_many(:orders) }


  describe '#create!' do
	 context 'with correct params' do

		let(:valid_user) { create(:user) }
		it { expect(valid_user).to be_valid }

	 end

	 context 'without name should generate a name' do
		let(:user) { create(:user_without_name) }
		it { expect(user.name).not_to be_nil }
	 end

	 context 'without email' do
		let(:invalid_user) { create(:user_without_email) }
		it { expect { invalid_user }.to raise_exception(ActiveRecord::RecordInvalid) }
	 end

  end

end
