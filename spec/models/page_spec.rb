require 'rails_helper'

RSpec.describe Page, type: :model do

  it { should respond_to(:page_images) }
  it { should have_many(:page_images) }

end
