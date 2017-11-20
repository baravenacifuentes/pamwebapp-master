class Component < ApplicationRecord
	belongs_to :gear
	has_many :units

	alias_attribute :children, :units
	has_methods :children
end
