require 'rails_helper'

RSpec.describe PageImage, type: :model do

  it { should respond_to (:page) }
  it { should respond_to (:picture) }

  it { should belong_to (:page) }

end
