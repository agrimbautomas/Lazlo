FactoryGirl.define do

  factory :order_status do

	 sequence(:name) {|n| "A random status #{n}"}
	 sequence(:priority) {|n| n}
	 visible true

	 factory :order_status_with_image do
		image {File.new(Rails.root.join('spec', 'photos', 'logo-green.png'))}
	 end

	 factory :order_status_not_visible do
		visible false
	 end

  end

end
