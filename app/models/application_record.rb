class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true

	def self.has_methods(*args)
		args.each do |arg|
			define_method "has_#{arg}?" do
				self.send(arg).any?
			end
		end
	end
end
