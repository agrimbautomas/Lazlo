require "rails_helper"

RSpec.describe ConfigValidator do
	before {
		class Example < Interactor
			validates_with ConfigValidator
		end
	}
	context 'check validation' do

		let(:home_promotion_config) { SiteConfig.create(caption: 'Some caption', config_type: :home_promotion, picture: nil) }

		let( :arguments_example ) { { site_config: home_promotion_config } }
		let( :interactor ) { Example.new arguments_example }

		it { expect{ interactor.arguments }.to raise_exception Error }

	end
end
