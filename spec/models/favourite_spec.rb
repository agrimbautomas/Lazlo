require 'rails_helper'
require 'contexts/for_models'

RSpec.describe Favourite, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :product }

  it { should respond_to (:user) }
  it { should respond_to (:product ) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:product ) }



  describe 'create Favourite' do
    include_context 'create user', :user
    include_context 'create product'

    context 'with correct params' do
      it 'the creation is valid' do
        expect(
          Favourite.create product: product, user: user
        ).to be_valid
      end
    end

    context 'with invalid product' do
      it 'the creation is invalid' do
        expect(
          Favourite.create product: nil, user: user
        ).not_to be_valid
      end
    end

    context 'with invalid user' do
      it 'the creation is invalid' do
        expect(
          Favourite.create product: product, user: nil
        ).not_to be_valid
      end
    end
  end
end
