class ProgrammingLanguage < ActiveRecord::Base

	attr_accessible :name, :available

	validates :name,
			  presence: true,
			  uniqueness: {case_sensitive: false},
			  length: {minimum: 1, maximum: 20}

	has_many :programs
	has_and_belongs_to_many :programming_tasks, uniq: true

	scope :available, where(available: true)
	scope :lexical, order('name ASC')

	default_scope lexical

end
