class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :encryptable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :confirmable, :omniauth_providers => [:facebook]


  has_one :favourites_list, :dependent => :destroy
  has_one :checkout_list, :dependent => :destroy
  has_one :purchased_list, :dependent => :destroy

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

  def has_product_as_favourite? product
    self.favourites_list.product_rows.where(:product => product).exists?
  end

end
