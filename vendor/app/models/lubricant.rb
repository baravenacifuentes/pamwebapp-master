class Lubricant < ApplicationRecord
	has_many :variables, inverse_of: :lubricant
	accepts_nested_attributes_for :variables, allow_destroy: true

	has_many :units
	has_many :samples, through: :units

	has_methods :units, :samples

	validates_presence_of :name, :max_hours

	validates_numericality_of :max_hours, greater_than_or_equal_to: 0

	def to_s
		name
	end
end
