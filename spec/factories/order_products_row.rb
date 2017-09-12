FactoryGirl.define do

  factory :order_products_row do
	 product
	 sequence(:product_name) {|n| "A random product name #{n}"}
	 sequence(:product_price) {|n| n}
	 sequence(:quantity) {|n| n}
  end

end
