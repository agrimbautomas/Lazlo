# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  name               :string
#  description        :text
#  price              :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  slug               :string
#  category_id        :integer
#  views              :integer          default(0)
#  featured           :boolean          default(FALSE)
#  visible            :boolean          default(TRUE)
#  deleted_at         :datetime
#

FactoryBot.define do

	factory :product do

		sequence(:name) { |n| "A random name #{n}" }
		sequence(:description) { |n| "A random description #{n}" }

		product_sizes { build_list :product_size, 3 }
		category


		factory :product_without_price do
			price nil
		end

		factory :product_with_image do
			image { File.new(Rails.root.join('spec', 'photos', 'logo-green.png')) }
		end
	end

end
