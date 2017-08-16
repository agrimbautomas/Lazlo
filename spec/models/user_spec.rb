# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string(255)      default(""), not null
#  password_salt          :string(32)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#

require 'rails_helper'

RSpec.describe User, type: :model do

  let (:john) { User.create! email: 'john@theamalgama.com', password: 'asd789de', password_confirmation: 'asd789de' }
  let (:tomas) { User.create! email: 'tomas@theamalgama.com', password: 'aad789de' }
  let (:paul) { User.create! email: 'paul@theamalgama.com', password: 'aad789de' }

  let (:category1) { Category.create!(name: 'Mesa Ratona') }
  let (:some_table) { Product.create!(name: 'A fake Product', description: 'Some random description, some random description',
                                      price: 2000, category: category1) }


  it { should respond_to (:email) }
  it { should respond_to (:password) }

  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }

  it { should respond_to(:favourites_list) }
  it { should have_one(:favourites_list) }

  it { should respond_to(:checkout_list) }
  it { should have_one(:checkout_list) }

  it { should respond_to(:purchased_list) }
  it { should have_one(:purchased_list) }

  it { should respond_to(:mercado_pago_purchases) }
  it { should have_many(:mercado_pago_purchases) }


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


    it 'should not have products on cart' do
      expect(john.has_product_in_cart? some_table).to be false
    end

    it 'should not have products as favourites' do
      expect(john.has_product_as_favourite? some_table).to be false
    end

    it 'should not have products bought' do
      expect(john.has_bought? some_table).to be false
    end

    it 'should have no products in cart count' do
      expect(john.cart_count).to eq(0)
    end

  end


  context "Setting Users data" do

    before(:each) do
      @user = User.new email: 'user@email.com', password: 'asdjoasdb'
      @user.save!
    end

  end


end
