require 'rails_helper'
require 'contexts/for_models'

RSpec.describe CreateFavourite do
	include_context 'create user', :user
	include_context 'create product'

	context 'with correct params' do
		it 'must be valid' do
			expect( CreateFavourite.with user: user, product: product ).to be_valid
		end
	end

	context 'when product has already been marked as a favourite' do
		include_context 'create favourite'
		it {
			expect {
				CreateFavourite.with user: user, product: favourite.product
			}.to raise_exception Error
		}
	end

	context 'without user' do
		it {
			expect {
				CreateFavourite.with user: nil, product: product
			}.to raise_exception Error
		}
	end

	context 'without product' do
		it {
			expect {
				CreateFavourite.with user: user, product: nil
			}.to raise_exception Error
		}
	end
end
