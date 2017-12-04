class GearType < Type
	has_many :gears, foreign_key: 'type_id'
	belongs_to :worst_sample, optional: true, class_name: 'Sample'

	alias_attribute :children, :gears
	has_methods :children

	def update_worst_sample
		gears.each do |gear|
			if gear.worst_sample.present?
				self.worst_sample = gear.worst_sample if self.worst_sample.nil? or self.worst_sample.state < gear.worst_sample.state
			end
		end
		self.save
	end
end
