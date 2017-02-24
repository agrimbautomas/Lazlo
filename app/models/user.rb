class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :encryptable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :confirmable, :omniauth_providers => [:facebook]


  has_many :products_lists, :dependent => :destroy
  attr_accessor :favourites_list, :chechkout_list, :purchased_list

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password.
      user = User.new(:email => data.email, :password => Devise.friendly_token[0, 20])
      user.skip_confirmation!
      user.save!
      user
    end
  end

  def favourites_list
    self.products_lists.find_by_category(1)
  end

end
