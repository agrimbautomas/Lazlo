require 'rails_helper'
require 'contexts/for_models'

RSpec.describe DeleteFavourite do
	include_context 'create favourite'
	include_context 'create user'

	context 'with correct params' do
		it 'must be valid' do
			expect(DeleteFavourite.with user: user, product: favourite.product).to be_valid
		end
	end

	context 'when product has not been marked as a favourite' do
		include_context 'create product'

		it {
			expect {
				DeleteFavourite.with user: user, product: product
			}.to raise_exception Error
		}
	end

	context 'without product' do
		it {
			expect {
				DeleteFavourite.with user: user, product: nil
			}.to raise_exception Error
		}
	end
end
