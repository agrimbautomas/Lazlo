require 'rails_helper'

RSpec.describe ProductRow, type: :model do

  it { should respond_to (:product) }
  it { should respond_to (:products_list) }

  it { should belong_to (:product) }
  it { should belong_to (:products_list) }

end
