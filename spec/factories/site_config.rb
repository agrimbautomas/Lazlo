FactoryBot.define do

	factory :site_config do

		sequence(:caption) { |n| "A random caption#{n}" }
		sequence(:config_type) { rand(0..3) }

		factory :most_liked_product_config do
			config_type { :most_liked_product }
			product
		end

	end

end
