FactoryGirl.define do

  factory :buyer do

	 sequence(:name) { |n| "A Buyer-name-#{n}" }

  end

end
