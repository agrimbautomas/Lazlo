RSpec.shared_context 'create user' do |role|
	let(:user) { create :user }
end

RSpec.shared_context 'create user with device' do
	include_context 'create user', :user
	let(:device) { create :device, user: user }
end

RSpec.shared_context 'create category' do
	let(:category) { create :category }
end

RSpec.shared_context 'create product' do
	let(:product) { create :product }
end

RSpec.shared_context 'create product size' do
	let(:product_size) { create :product_size }
end

RSpec.shared_context 'create order' do
	let(:order) { create :order }
end

RSpec.shared_context 'create product row' do
	let(:product_row) { create :product_row }
end

RSpec.shared_context 'create favourite' do |role|
	include_context 'create product'
	include_context 'create user', :user
	let(:favourite) { create :favourite, product: product, user: user }
end


RSpec.shared_context 'create most liked product config' do
	include_context 'create product'
	let(:most_liked_product_config) { create :most_liked_product_config }
end


