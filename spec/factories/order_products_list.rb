FactoryGirl.define do

  factory :order_products_list do
	 order_products_rows {build_list(:order_products_row, 3)}
  end

end
