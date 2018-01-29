class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true

	def self.has_methods(*args)
		args.each do |arg|
			define_method "has_#{arg}?" do
				self.send(arg).any?
			end
		end
	end

	# plural names
	def self.pluralize
		model_name.human.pluralize(I18n.locale)
	end

	def pluralize
		self.class.pluralize
	end

	# singular names
	def self.singularize
		model_name.human
	end

	def singularize
		self.class.singularize
	end

	# get attribute name from any instance
	def self.attribute_name(attribute)
		human_attribute_name attribute
	end

	def attribute_name(attribute)
		self.class.attribute_name attribute
	end
end
