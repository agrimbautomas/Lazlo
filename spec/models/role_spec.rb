require 'rails_helper'

RSpec.describe Role, type: :model do

  it { should respond_to (:resource) }
  it { should respond_to (:resource_type) }

  it { should belong_to (:resource) }
  it { should have_and_belong_to_many (:admin_users) }

end
