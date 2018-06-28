FactoryGirl.define do

	factory :marvel do

		sequence(:name) { |n| "A random name #{n}" }

		sequence(:price) { |n| n }

		factory :marvel_without_price do
			price nil
		end

	end

end
