# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  password_salt          :string(32)
#  provider               :string
#  uid                    :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :encryptable,
			:recoverable, :rememberable, :trackable, :validatable,
			:omniauthable, :confirmable, :omniauth_providers => [:facebook]


  has_one :favourites_list, :dependent => :destroy
  has_one :checkout_list, :dependent => :destroy
  has_one :purchased_list, :dependent => :destroy
  has_many :mercado_pago_purchases, :dependent => :destroy

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

  def add_product_to_cart product
	 self.checkout_list = CheckoutList.create(:user => self) unless self.checkout_list.present?
	 self.checkout_list.save_product_row product
	 self.save!
  end

  def has_product_in_cart? product
	 checkout_list.present? and checkout_list.product_rows.present? and checkout_list.product_rows.where(:product => product).exists?
  end

  def has_product_as_favourite? product
	 favourites_list.present? and favourites_list.product_rows.present? and favourites_list.product_rows.where(:product => product).exists?
  end

  def has_bought? product
	 purchased_list.present? and purchased_list.product_rows.present? and purchased_list.product_rows.where(:product => product).exists?
  end

  def cart_count
	 checkout_list.present? ? checkout_list.product_rows.count : 0
  end

  def store_checkout_list
	 create_purchased_list if create_purchased_list.nil?
	 checkout_list.product_rows.each { |row| purchased_list.product_rows << row }
	 purchased_list.save!
	 #checkout_list.product_rows.destroy_all
  end
end
