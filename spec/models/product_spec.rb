require 'rails_helper'

RSpec.describe Product, type: :model do


  let(:category1) { Category.create!(name: 'Mesa Ratona') }
  let(:a_product) { Product.new(name: 'Another fake Product', price: 5000, category: category1,
                            description: 'Some random description, some random description') }

  it { should respond_to (:name) }
  it { should respond_to (:payment) }

  #it { should have_one(:category) }
  it { should have_many(:orders) }
  it { should have_many(:product_images) }
  it { should have_many(:product_rows) }

  it { should validate_presence_of(:name) }

  #it { should have_attached_file(:image) }

  describe 'when is created' do

    it 'should have validations params' do
      expect(a_product).to be_valid
    end

    it 'should have a slug' do

    end
  end

  describe 'Class methods' do

    it 'should get featured products' do
      featured_products = Product.limit(6).order('featured desc, views desc')
      expect(Product.featured).to eq(featured_products)
    end

  end


end
