class VariableType < Type
	has_many :variables

	validates_presence_of :name

	def to_s
		name
	end
end
