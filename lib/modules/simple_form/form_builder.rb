module SimpleForm
	class FormBuilder
		def divider(class_name='col-sm-9')
			"<div class=\"row justify-content-end\"><div class=\"#{class_name}\"><hr></div></div>".html_safe
		end
	end
end
