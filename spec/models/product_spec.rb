require 'rails_helper'

RSpec.describe Product, type: :model do


  let(:category1) { Category.create!(name: 'Mesas De Comedor') }
  let(:a_product) { Product.create!(name: 'Cubo Tamaño Grande', price: 5000, category: category1,
                            description: 'Some random description, some random description') }

  it { should respond_to (:name) }
  it { should respond_to (:payment) }

  it { should belong_to(:category) }
  it { should have_many(:orders) }
  it { should have_many(:product_images) }
  it { should have_many(:product_rows) }

  it { should validate_presence_of(:name) }

  it { should have_attached_file(:image) }

  describe 'when is created' do

    it 'should have validations params' do
      expect(a_product).to be_valid
    end

    it 'should have a slug from title' do
      expect(a_product.slug).to eq('cubo-tamano-grande')
    end

    it 'should have a slug unique slug' do
      expect(a_product.slug).to eq('cubo-tamano-grande')
      table = Product.create!(name: 'A Table', price: 5000, category: category1,
                      description: 'Some random description')
      other_table = Product.create!(name: 'A Table', price: 5000, category: category1,
                      description: 'Some random description')
      expect(table.slug).not_to eq(other_table.slug)
    end
  end

  describe 'When file is uploaded' do
    it 'Should have an attachment' do
      a_product.image = File.new("#{Rails.root}/spec/fixtures/images/logo-green.png")

      expect(a_product.image ).to be_a(Paperclip::Attachment)
    end

  end

  describe 'Class methods' do

    it 'should get featured products' do
      featured_products = Product.limit(6).order('featured desc, views desc')
      expect(Product.featured).to eq(featured_products)
    end

  end


end
