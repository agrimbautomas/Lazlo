class UserContact < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
end
