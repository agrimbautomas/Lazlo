require 'rails_helper'
require 'contexts/for_models'

RSpec.describe DeleteFavourite do
	include_context 'create favourite'

	context 'with correct params' do
		it 'must be valid' do
			expect( DeleteFavourite.with product: favourite.product ).to be_valid
		end
	end

	context 'when product has not been marked as a favourite' do
		include_context 'create product'
		it {
			expect {
				DeleteFavourite.with product: product
			}.to raise_exception Error
		}
	end

	context 'without product' do
		it {
			expect {
				DeleteFavourite.with product: nil
			}.to raise_exception Error
		}
	end
end
