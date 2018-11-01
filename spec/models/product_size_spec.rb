require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'creation is valid' do
	it 'creation is valid' do
		expect(
			ProductSize.create(
				name: name,
				price: price,
				product: product,
			)
		).to be_valid
	end
end

RSpec.describe ProductSize, type: :model do

	it { should respond_to (:name) }
	it { should validate_presence_of (:name) }
	it { should allow_value(false).for(:name) }
	it { should validate_length_of(:name).is_at_most(255) }

	it { should respond_to (:price) }
	it { should validate_presence_of (:price) }
	it { should validate_numericality_of(:price).is_greater_than(0) }

	it { should respond_to(:product) }
	it { should belong_to(:product) }


	describe '#create' do
		include_context 'create product'
		let( :price ) { 500.50 }
		let( :name ) { '150cm x 200cm' }

		context 'with all parameters' do
			include_examples 'creation is valid'
		end
		
	end

end
