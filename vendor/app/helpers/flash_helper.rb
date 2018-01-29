module FlashHelper
	def flash_message(object, action, type)
		flash[type] = I18n.t type, scope: [:flash, :actions, action], resource_name: object.model_name.human.singularize
	end
end
