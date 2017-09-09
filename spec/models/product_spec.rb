# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :text(65535)
#  price              :float(24)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  slug               :string(255)
#  category_id        :integer
#  views              :integer          default(0)
#  featured           :boolean          default(FALSE)
#  visible            :boolean          default(TRUE)
#

require 'rails_helper'

RSpec.describe Product, type: :model do

  it {should respond_to (:name)}
  it {should respond_to (:price)}
  it {should respond_to (:slug)}

  it {should belong_to(:category)}
  it {should have_many(:orders)}
  it {should have_many(:product_images)}
  it {should have_many(:product_rows)}

  it {should validate_presence_of(:name)}

  it {should have_attached_file(:image)}

  describe '#create!' do
	 context 'with correct params' do
		let(:valid_product) {create(:valid_product)}
		it {expect(valid_product).to be_valid}

		it 'should have a slug from title' do
		  expect(valid_product.slug).to eq('cubo-tamano-grande')
		end

		it 'should have a slug unique slug' do
		  expect(valid_product.slug).to eq('cubo-tamano-grande')
		  table = Product.create!(name: 'A Table', price: 5000, category: category1,
										  description: 'Some random description')
		  other_table = Product.create!(name: 'A Table', price: 5000, category: category1,
												  description: 'Some random description')
		  expect(table.slug).not_to eq(other_table.slug)
		end
	 end


	 describe 'When file is uploaded' do
		it 'Should have an attachment' do
		  let(:product_with_image) {create(:product_with_image)}
		  expect(product_with_image.image).to be_a(Paperclip::Attachment)
		end

	 end
  end

  describe 'Class methods' do
	 it 'should get featured products' do
		featured_products = Product.limit(6).order('featured desc, views desc')
		expect(Product.featured).to eq(featured_products)
	 end

  end

end


