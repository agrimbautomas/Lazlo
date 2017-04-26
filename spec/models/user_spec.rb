require 'rails_helper'

RSpec.describe User, type: :model do

  let (:john) { User.create! email: 'john@theamalgama.com', password: 'asd789de' }
  let (:tomas) { User.create! email: 'tomas@theamalgama.com', password: 'aad789de' }
  let (:paul) { User.create! email: 'paul@theamalgama.com', password: 'aad789de' }

  it { should respond_to (:email) }
  it { should respond_to (:password) }

  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }

  it { should have_one(:favourites_list) }
  it { should have_one(:checkout_list) }
  it { should have_one(:purchased_list) }



  context "on Create" do

    it 'should not be valid without email nor password' do
      user = User.new
      expect(user).to_not be_valid
    end

    it 'should not be valid without password' do
      user = User.new email: 'user@email.com'
      expect(user).to_not be_valid
    end

    it 'should not be valid without email' do
      user = User.new password: 'a1ace234a'
      expect(user).to_not be_valid
    end

    it 'should be valid with email and password' do
      user = User.new email: 'user@email.com', password: 'asdjoasdb'
      expect(user).to be_valid
    end


  end


  context "Setting Users data" do

    before(:each) do
      @user = User.new email: 'user@email.com', password: 'asdjoasdb'
      @user.save!
    end


  end

end
