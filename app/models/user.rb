class User < ActiveRecord::Base

	devise :database_authenticatable, :registerable,
		   :recoverable, :rememberable, :trackable, :validatable

	# Other available modules are: :token_authenticatable, :encryptable,
	# :confirmable, :lockable, :timeoutable and :omniauthable

	attr_accessible :email, :password, :password_confirmation, :remember_me
end
