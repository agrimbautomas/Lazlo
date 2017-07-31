# == Schema Information
#
# Table name: marvels
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Marvel, type: :model do

  it { should respond_to (:name) }
  it { should respond_to (:price) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }

end
