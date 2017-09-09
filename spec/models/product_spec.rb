# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  name               :string
#  description        :text
#  price              :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  slug               :string
#  category_id        :integer
#  views              :integer          default(0)
#  featured           :boolean          default(FALSE)
#  visible            :boolean          default(TRUE)
#

require 'rails_helper'

RSpec.describe Product, type: :model do

  it {should respond_to (:name)}
  it {should validate_presence_of (:name)}
  it {should allow_value(false).for(:name)}
  it {should validate_length_of(:name).is_at_most(255)}
  it {should validate_uniqueness_of(:name).ignoring_case_sensitivity}

  it {should respond_to (:price)}
  it {should validate_presence_of (:price)}
  it {should validate_numericality_of(:price).is_greater_than(0)}

  it {should respond_to (:slug)}
  it {should validate_presence_of (:slug)}

  it {should respond_to(:category)}
  it {should belong_to(:category)}

  it {should respond_to(:orders)}
  it {should have_many(:orders)}

  it {should respond_to(:product_images)}
  it {should have_many(:product_images)}

  it {should respond_to(:product_rows)}
  it {should have_many(:product_rows)}

  it {should respond_to (:image)}
  it {should have_attached_file(:image)}


  describe '#create!' do

	 let(:valid_product) {create(:product)}

	 context 'with correct params' do
		it {
		  expect(valid_product).to be_valid
		}
	 end

	 context 'should have a slug from name' do
		it {
		  valid_product.update_attribute(:name, 'Cubo tamaño Grande')
		  expect(valid_product.slug).to eq('cubo-tamano-grande')
		}

		it 'should create a slug unique slugs' do
		  new_product = build(:product)
		  new_product.name = valid_product.name + "@"
		  new_product.save!

		  expect(new_product.slug).not_to eq(valid_product.slug)
		end
	 end


	 describe 'When file is uploaded' do
		let(:product_with_image) {create(:product_with_image)}
		it 'Should have an attachment' do
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


