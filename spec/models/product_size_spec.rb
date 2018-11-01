require 'rails_helper'
require 'contexts/for_models'

RSpec.describe ProductSize, type: :model do

	it { should respond_to (:name) }
	it { should validate_presence_of (:name) }
	it { should allow_value(false).for(:name) }
	it { should validate_length_of(:name).is_at_most(255) }

	it { should respond_to (:price) }
	it { should validate_presence_of (:price) }
	it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

	it { should respond_to(:product) }
	it { should belong_to(:product) }


	describe '#create' do
		include_context 'create product'
		include_context 'create product size'

		context 'with all parameters' do
			it { expect(product_size).to be_valid }
		end

		context 'with same name reference' do
			let!(:product_size1) { ProductSize.create(name: '100x100cm', price: 100, product: product) }
			let(:product_size2) { ProductSize.create(name: '100x100cm', price: 150, product: product) }
			it { expect(product_size2).not_to be_valid }
		end

		context 'with same different name reference' do
			let(:another_product) { create :product }
			let!(:product_size1) { ProductSize.create(name: '100x100cm', price: 100, product: product) }
			let(:product_size2) { ProductSize.create(name: '100x100cm', price: 150, product: another_product) }
			it { expect(product_size2).to be_valid }
		end

	end

end
