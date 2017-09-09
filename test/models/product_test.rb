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
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
