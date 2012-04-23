class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # guest user (not logged in)
		if user.roles.empty?
			guest
		else
			user.roles.each { |role| send(role) }
		end
	end

	private

	def admin
		can :manage, :all
	end

	def author
		member
		can :manage, ProgrammingTask
		can :manage, ProgrammingTestCase
	end

	def member
		can :read, :all
		can :manage, Program
	end

	def guest
		can :read, :all
	end

	def banned
		can :read, :all
	end
end
