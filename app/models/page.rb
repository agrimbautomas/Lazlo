# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Page < ApplicationRecord
  has_many :page_images, :dependent => :destroy

  accepts_nested_attributes_for :page_images, :allow_destroy => true
end
