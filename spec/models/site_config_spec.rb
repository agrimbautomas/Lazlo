require 'rails_helper'
require 'contexts/for_models'

RSpec.describe SiteConfig, type: :model do

	it { should respond_to (:caption) }
	it { should validate_presence_of (:caption) }
	it { should allow_value(false).for(:caption) }
	it { should validate_length_of(:caption).is_at_most(255) }

	it { should respond_to (:picture) }
	it { should have_attached_file(:picture) }

	it { should respond_to (:product) }

	it { should respond_to (:config_type) }
	it { should validate_presence_of (:config_type) }
	it { expect define_enum_for(:config_type).with [
			:home_slide,
			:home_support,
			:home_promotion,
			:most_liked_product
	] }

	describe 'create SiteConfig' do

		let(:image) { File.new(Rails.root.join('spec', 'photos', 'logo-green.png')) }
		let(:home_promotion_config) { SiteConfig.create(caption: 'Some caption', config_type: :home_promotion, picture: image) }
		include_context 'create product'

		context 'with correct params' do
			it 'the creation is valid' do
				expect(
						SiteConfig.create(
								caption: 'Some caption',
								config_type: :home_support,
								picture: image
						)
				).to be_valid
			end

			it 'should have an attachment' do

				expect(home_promotion_config.picture).to be_a(Paperclip::Attachment)
			end

		end

		context 'without config_type' do
			it 'the creation is valid' do
				expect(
						SiteConfig.create(
								caption: 'Some caption',
								config_type: nil,
								picture: image
						)
				).not_to be_valid
			end
		end

		context 'without picture when needed' do
			it 'the creation is valid' do
				expect(
						SiteConfig.create(
								caption: 'Some caption',
								config_type: :home_support,
								picture: nil
						)
				).not_to be_valid
			end
		end

		context 'without image and most_liked_product' do
			it 'the creation is valid' do
				expect(
						SiteConfig.create(
								caption: 'Some caption',
								config_type: :most_liked_product,
								picture: nil,
								product: product
						)
				).to be_valid
			end
		end

		context 'without product and most_liked_product' do
			it 'the creation is valid' do
				expect(
						SiteConfig.create(
								caption: 'Some caption',
								config_type: :most_liked_product,
								picture: nil,
								product: nil
						)
				).not_to be_valid
			end
		end


	end


end
