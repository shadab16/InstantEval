class User < ActiveRecord::Base

	devise :database_authenticatable, :registerable,
		   :recoverable, :rememberable, :trackable, :validatable

	# Other available modules are: :token_authenticatable, :encryptable,
	# :confirmable, :lockable, :timeoutable and :omniauthable

	attr_accessible :email, :password, :password_confirmation, :remember_me

	ROLES = %w[admin author member banned]

	def roles=(roles)
		self.roles_mask = (roles & ROLES).map { |r| 2 ** ROLES.index(r) }.sum
	end

	def roles
		ROLES.reject do |r|
			((roles_mask || 0) & 2 ** ROLES.index(r)).zero?
		end
	end

	def is?(role)
		roles.include?(role.to_s)
	end

end
