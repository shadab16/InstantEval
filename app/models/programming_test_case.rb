class ProgrammingTestCase < ActiveRecord::Base

	attr_accessible :stdin, :stdout, :hidden

	validates :stdin, presence: true
	validates :stdout, presence: true

	belongs_to :programming_task, inverse_of: :programming_test_cases

	before_validation :normalize_newlines

	def normalize_newlines
		self.stdin.gsub!(/\r\n?/, "\n")
		self.stdin.strip!
		self.stdout.gsub!(/\r\n?/, "\n")
		self.stdout.strip!
	end

end
