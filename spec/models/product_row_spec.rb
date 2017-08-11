# == Schema Information
#
# Table name: product_rows
#
#  id               :integer          not null, primary key
#  quantity         :integer          default(1)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :integer
#  products_list_id :integer
#

require 'rails_helper'

RSpec.describe ProductRow, type: :model do

  it { should respond_to (:product) }

  it { should belong_to (:product) }

end
