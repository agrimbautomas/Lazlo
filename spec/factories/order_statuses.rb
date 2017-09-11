# == Schema Information
#
# Table name: order_statuses
#
#  id                 :integer          not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  priority           :integer
#  visible            :boolean          default(TRUE)
#



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
