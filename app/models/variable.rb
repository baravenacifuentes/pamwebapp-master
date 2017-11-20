class Variable < ApplicationRecord
	belongs_to :lubricant
	belongs_to :type
	has_many :sample_variables
end
