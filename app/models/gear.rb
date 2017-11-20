class Gear < ApplicationRecord
	belongs_to :type, class_name: 'GearType'
	has_many :components

	alias_attribute :children, :components
	has_methods :children
end
