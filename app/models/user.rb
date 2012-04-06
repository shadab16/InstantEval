class User < ActiveRecord::Base

	attr_accessible :name, :email, :password, :password_confirmation

	validates :name,
			  presence: true,
			  length: {minimum: 5, maximum: 30},
			  uniqueness: {case_sensitive: false}

	validates :email,
			  presence: true,
			  length: {minimum: 3, maximum: 254},
			  uniqueness: {case_sensitive: false}

	validates :password, presence: true, minimum: {length: 8}
	validates :password_confirmation, presence: true

	has_secure_password

	has_many :programs, dependent: :destroy, inverse_of: :user
end
