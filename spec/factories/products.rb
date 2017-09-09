FactoryGirl.define do

  factory :product do

	 sequence(:name) {|n| "A random status #{n}"}
	 sequence(:description) {|n| "A random description #{n}"}
	 sequence(:price) {|n| "A random price #{n}"}


	 factory :product_without_price do
		price nil
	 end

	 factory :product_with_image do
		image {File.new(Rails.root.join('spec', 'photos', 'logo-green.png'))}
	 end
  end

end
