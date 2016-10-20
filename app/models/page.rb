class Page < ActiveRecord::Base
  has_many :page_images, :dependent => :destroy

  accepts_nested_attributes_for :page_images, :allow_destroy => true
end
