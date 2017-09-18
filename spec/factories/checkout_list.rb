FactoryGirl.define do

  factory :checkout_list do
	 user
	 product_rows { build_list(:product_row, 3) }
  end

end
