FactoryGirl.define do

	factory :order do

		sequence(:title) { |n| "An Order-title-#{n}" }
		sequence(:detail) { |n| "An Order-detail-#{n}" }
		sequence(:code) { |n| n }
		sequence(:status) { rand(0..5) }
		user
		buyer
		order_products_list
	end

end
