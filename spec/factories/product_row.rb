FactoryBot.define do

  factory :product_row do
	 product
	 sequence(:quantity) { |n| n }
  end

end
