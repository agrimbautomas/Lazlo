FactoryBot.define do
	factory :product_size do
		sequence(:name) { |n| "A random name #{n}" }
		sequence(:price) { |n| n }

	end
end
