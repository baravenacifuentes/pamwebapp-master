class Unit < ApplicationRecord
	belongs_to :component
	belongs_to :lubricant
	has_many :samples

	def has_children?
		false
	end
end
