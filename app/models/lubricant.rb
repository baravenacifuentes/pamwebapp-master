class Lubricant < ApplicationRecord
	has_many :variables
	has_many :units
	has_many :samples
end
