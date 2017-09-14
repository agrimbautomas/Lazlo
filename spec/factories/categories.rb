# == Schema Information
#
# Table name: categories
#
#  id                 :integer          not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  slug               :string
#  views              :integer          default(0)
#  description        :string
#

FactoryGirl.define do

  factory :category do

	 sequence(:name) {|n| "A random name #{n}"}
	 sequence(:description) {|n| "A random description #{n}"}
	 
	 factory :category_without_price do
		price nil
	 end

	 factory :category_with_image do
		image {File.new(Rails.root.join('spec', 'photos', 'logo-green.png'))}
	 end
  end

end
