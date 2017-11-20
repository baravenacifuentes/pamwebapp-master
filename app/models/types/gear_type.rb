class GearType < Type
	has_many :gears, foreign_key: 'type_id'

	alias_attribute :children, :gears
	has_methods :children

end
