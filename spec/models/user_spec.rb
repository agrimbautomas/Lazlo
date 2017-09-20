# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  password_salt          :string(32)
#  provider               :string
#  uid                    :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  deleted_at             :datetime
#

require 'rails_helper'

RSpec.describe User, type: :model do

  it_behaves_like 'a Paranoid model'

  it { should respond_to(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should validate_length_of(:email).is_at_most(255) }

  it { should respond_to (:password) }
  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }

  it { should respond_to(:favourites_list) }
  it { should have_one(:favourites_list) }

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
