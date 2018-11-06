require 'rails_helper'
require 'contexts/for_models'

RSpec.describe Product, type: :model do

  it_behaves_like 'a Paranoid model'

  it {should respond_to (:name)}
  it {should validate_presence_of (:name)}
  it {should allow_value(false).for(:name)}
  it {should validate_length_of(:name).is_at_most(255)}
  it {should validate_uniqueness_of(:name).ignoring_case_sensitivity}

  it {should respond_to (:slug)}
  it {should validate_presence_of (:slug)}

  it {should respond_to(:category)}
  it {should belong_to(:category)}

  it {should respond_to(:orders)}
  it {should have_many(:orders).dependent(:destroy)}

  it {should respond_to(:favourites)}
  it {should have_many(:favourites).dependent(:destroy)}

  it {should respond_to(:product_images)}
  it {should have_many(:product_images).dependent(:destroy)}

  it {should respond_to(:product_rows)}
  it {should have_many(:product_rows).dependent(:destroy)}

  it {should respond_to(:product_sizes)}
  it {should have_many(:product_sizes).dependent(:destroy)}

  it {should respond_to (:image)}
  it {should have_attached_file(:image)}

  it {should respond_to (:size)}
  it {should respond_to (:price)}

  describe '#create!' do

    include_context 'create product'

    context 'with correct params' do
      it {expect(product).to be_valid}
    end

    context 'should have a slug from name' do
      it 'should match the slug' do
        product.update_attribute(:name, 'Cubo tamaño Grande')
        expect(product.slug).to eq('cubo-tamano-grande')
      end

      it 'should create a slug unique slugs' do
        new_product = build(:product)
        new_product.name = product.name + "@"
        new_product.save!

        expect(new_product.slug).not_to eq(product.slug)
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
    include_context 'create product'

    it 'should get featured products' do
      featured_products = Product.limit(6).order('featured desc, views desc')
      expect(Product.featured).to eq(featured_products)
    end


    context 'with many sizes' do
      before {
        product.product_sizes.each {|ps| ps.update_attributes(:price => 1000)}
        product.product_sizes.second.update_attributes(:price => 500)
      }

      it 'should get the price of the cheaper size' do
        expect(product.price).to eq(product.product_sizes.second.price)
      end

      it 'should get the size of the cheaper size' do
        expect(product.size).to eq(product.product_sizes.second.name)
      end

    end

  end

end


