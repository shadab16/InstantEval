class ProgrammingTask < ActiveRecord::Base

	attr_accessible :name, :statement, :input_format, :time_limit, :memory_limit,
					:programming_language_ids, :programming_test_cases_attributes

	validates :name, presence: true
	validates :statement, presence: true
	validates :time_limit, presence: true, numericality: {greater_than: 0}
	validates :memory_limit, presence: true, numericality: {greater_than: 0}

	validates :programming_language_ids, presence: true
	validates :programming_test_cases, presence: true

	has_and_belongs_to_many :programming_languages, uniq: true, readonly: true
	has_many :programs, dependent: :destroy
	has_many :programming_test_cases, dependent: :destroy

	accepts_nested_attributes_for :programming_test_cases,
		reject_if: :all_blank, allow_destroy: true

	before_validation :mark_test_cases_for_removal

	def mark_test_cases_for_removal
		programming_test_cases.each do |testcase|
			testcase.mark_for_destruction if testcase.stdin.blank? and testcase.stdout.blank?
		end
	end

end
