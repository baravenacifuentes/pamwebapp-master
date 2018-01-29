class Variable < ApplicationRecord
	belongs_to :lubricant
	belongs_to :type, class_name: 'VariableType'
	has_many :sample_variables

	validates_presence_of :min, :mid, :max
end
