FactoryGirl.define do

  factory :order do

	 sequence(:title) { |n| "An Order-title-#{n}" }
	 sequence(:detail) { |n| "An Order-detail-#{n}" }
	 sequence(:code) { |n| n }
	 user
	 buyer
	 order_products_list
  end

end
