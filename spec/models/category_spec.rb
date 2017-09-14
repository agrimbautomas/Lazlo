# == Schema Information
#
# Table name: categories
#
#  id                 :integer          not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  slug               :string
#  views              :integer          default(0)
#  description        :string
#

require 'rails_helper'

RSpec.describe Category, type: :model do

  it { should respond_to (:name) }
  it { should validate_presence_of (:name) }
  it { should allow_value(false).for(:name) }
  it { should validate_length_of(:name).is_at_most(255) }
  it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }

  it { should respond_to (:description) }
  it { should validate_presence_of (:description) }
  it { should allow_value(false).for(:description) }
  it { should validate_length_of(:description).is_at_most(160) }

  it { should respond_to (:slug) }
  it { should validate_presence_of (:slug) }
  it { should allow_value(false).for(:slug) }
  it { should validate_length_of(:slug).is_at_most(255) }

  it { should respond_to (:products) }
  it { should have_many (:products) }

  it { should respond_to (:image) }
  it { should have_attached_file(:image) }

  describe '#create!' do

	 let(:valid_category) { create(:category) }

	 context 'with correct params' do
		it { expect(valid_category).to be_valid }
	 end

	 context 'should have a slug from name' do
		it {
		  valid_category.update_attribute(:name, 'Mesas Ratonas')
		  expect(valid_category.slug).to eq('mesas-ratonas')
		}

		it 'should create a slug unique slugs' do
		  new_category = build(:category)
		  new_category.name = valid_category.name + "@"
		  new_category.save!

		  expect(new_category.slug).not_to eq(valid_category.slug)
		end
	 end


	 describe 'When file is uploaded' do
		let(:category_with_image) { create(:category_with_image) }
		it 'Should have an attachment' do
		  expect(category_with_image.image).to be_a(Paperclip::Attachment)
		end

	 end
  end



end


