class User < ActiveRecord::Base

	before_save :assign_default_role

	devise :database_authenticatable, :registerable,
		   :recoverable, :rememberable, :trackable, :validatable

	# Other available modules are: :token_authenticatable, :encryptable,
	# :confirmable, :lockable, :timeoutable and :omniauthable

	attr_accessible :username, :email, :password, :password_confirmation, :remember_me

	# Virtual attribute for authenticating the user by username or email

	attr_accessor :login
	attr_accessible :login

	validates :username, presence: true, uniqueness: {case_sensitive: false}

	has_many :programs, readonly: true
	has_many :programming_tasks, readonly: true

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

	def assign_default_role
		self.roles = %w[member] if self.roles.blank?
	end

	def self.find_first_by_auth_conditions(warden_conditions)
		conditions = warden_conditions.dup
		login = conditions.delete(:login)
		if login
			where(conditions).where(
				['lower(username) = :value OR lower(email) = :value', {value: login.downcase}]
			).first
		else
			where(conditions).first
		end
	end

end
