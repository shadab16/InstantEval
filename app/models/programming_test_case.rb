class ProgrammingTestCase < ActiveRecord::Base

	attr_accessible :stdin, :stdout

	validates :stdin, presence: true
	validates :stdout, presence: true

	belongs_to :programming_task, inverse_of: :programming_test_cases

end
