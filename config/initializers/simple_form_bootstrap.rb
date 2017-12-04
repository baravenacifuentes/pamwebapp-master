# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
	config.error_notification_tag = nil
	config.error_notification_class = 'alert alert-danger alert-dismissible fade show'
	config.error_method = :to_sentence
	config.button_class = 'btn btn-primary float-right'
	config.boolean_label_class = 'form-check-label'
	config.boolean_style = :nested
	config.form_class = nil
	config.i18n_scope = 'simple_form'
	config.translate_labels = true
	config.browser_validations = false
	config.generate_additional_classes_for = []

	config.default_wrapper = :horizontal_form
	config.wrapper_mappings = {
		check_boxes: :horizontal_radio_and_checkboxes,
		radio_buttons: :horizontal_radio_and_checkboxes,
		file: :horizontal_file_input,
		boolean: :horizontal_boolean,
		datetime: :multi_select,
		date: :multi_select,
		time: :multi_select
	}

	config.wrappers :horizontal_form, tag: :div, class: 'form-group row', error_class: 'has-danger' do |b|
		b.use :html5
		b.use :placeholder
		b.optional :maxlength
		b.optional :pattern
		b.optional :min_max
		b.optional :readonly
		b.use :label, class: 'col-sm-3 col-form-label'

		b.wrapper tag: :div, class: 'col-sm-9' do |ba|
			ba.use :input, class: 'form-control'
			ba.use :full_error, wrap_with: { tag: :div, class: 'invalid-feedback' }
			ba.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
		end
	end

	config.wrappers :horizontal_boolean, tag: :div, class: 'form-check row justify-content-end', error_class: 'has-danger' do |b|
		b.use :html5
		b.optional :readonly

		b.wrapper tag: :div, class: 'col-sm-9' do |wr|
			wr.use :label_input, class: 'form-check-input'
			wr.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
			wr.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
		end
	end

	config.wrappers :horizontal_file_input, tag: :div, class: 'form-group row', error_class: 'has-danger' do |b|
		b.use :html5
		b.use :placeholder
		b.optional :maxlength
		b.optional :readonly
		b.use :label, class: 'col-sm-3 col-form-label'

		b.wrapper tag: :div, class: 'col-sm-9' do |ba|
			ba.use :input, class: 'form-control-file'
			ba.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
			ba.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
		end
	end

	config.wrappers :horizontal_radio_and_checkboxes, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
		b.use :html5
		b.optional :readonly

		b.use :label, class: 'col-sm-3 col-form-label'

		b.wrapper tag: :div, class: 'col-sm-9' do |ba|
			ba.use :input, class: 'form-check-input'
			ba.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
			ba.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
		end
	end

	config.wrappers :vertical_form, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
		b.use :html5
		b.use :placeholder
		b.optional :maxlength
		b.optional :pattern
		b.optional :min_max
		b.optional :readonly
		b.use :label

		b.use :input, class: 'form-control'
		b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
		b.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
	end

	config.wrappers :vertical_file_input, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
		b.use :html5
		b.use :placeholder
		b.optional :maxlength
		b.optional :readonly
		b.use :label

		b.use :input, class: 'form-control-file'
		b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
		b.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
	end

	config.wrappers :vertical_boolean, tag: :div, class: 'form-check', error_class: 'has-danger' do |b|
		b.use :html5
		b.optional :readonly
		b.use :label_input, class: 'form-check-input'

		b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
		b.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
	end

	config.wrappers :vertical_radio_and_checkboxes, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
		b.use :html5
		b.optional :readonly
		b.use :label, class: 'form-check-label'
		b.use :input, class: 'form-check-input'
		b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
		b.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
	end

	config.wrappers :inline_form, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
		b.use :html5
		b.use :placeholder
		b.optional :maxlength
		b.optional :pattern
		b.optional :min_max
		b.optional :readonly
		b.use :label

		b.use :input, class: 'form-control'
		b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
		b.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
	end

	config.wrappers :multi_select, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
		b.use :html5
		b.optional :readonly
		b.use :label
		b.wrapper tag: :div, class: 'form-inline' do |ba|
			ba.use :input, class: 'form-control'
			ba.use :full_error, wrap_with: { tag: :div, class: 'invalid-feedback' }
			ba.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
		end
	end

	config.wrappers :input_with_placeholder, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
		b.use :html5
		b.use :placeholder
		b.optional :maxlength
		b.optional :pattern
		b.optional :min_max
		b.optional :readonly
		b.use :input, class: 'form-control'
		b.use :full_error, wrap_with: { tag: :div, class: 'invalid-feedback' }
		b.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
	end

	config.wrappers :email_at, tag: :div, class: 'form-group row', error_class: 'has-danger' do |b|
		b.use :html5
		b.use :placeholder
		b.optional :maxlength
		b.optional :pattern
		b.optional :min_max
		b.optional :readonly
		b.use :label, class: 'col-sm-3 col-form-label'

		b.wrapper tag: :div, class: 'col-sm-9' do |ba|
			ba.wrapper tag: :div, class: 'input-group' do |bb|
				bb.use :input, class: 'form-control'
				bb.use :at, wrap_with: { tag: :div, class: 'input-group-addon' }
			end
			ba.use :full_error, wrap_with: { tag: :div, class: 'invalid-feedback' }
			ba.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
		end
	end

	config.wrappers :single_line_nested_item, tag: :div, class: 'form-group row', error_class: 'has-danger' do |b|
		b.use :html5
		b.use :placeholder
		b.optional :maxlength
		b.optional :pattern
		b.optional :min_max
		b.optional :readonly
		b.use :label, class: 'col-sm-3 col-form-label'

		b.wrapper tag: :div, class: 'col-10 col-sm-8' do |ba|
			ba.use :input, class: 'form-control'
			ba.use :full_error, wrap_with: { tag: :div, class: 'invalid-feedback' }
			ba.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
		end

		b.wrapper tag: :div, class: 'col-2 col-sm-1' do |ba|
			ba.use :remove_link
		end
	end

	config.wrappers :chosen_select, tag: :div, class: 'form-group row', error_class: 'has-danger' do |b|
		b.use :html5
		b.use :placeholder
		b.optional :maxlength
		b.optional :pattern
		b.optional :min_max
		b.optional :readonly
		b.use :label, class: 'col-sm-3 col-form-label'

		b.wrapper tag: :div, class: 'col-sm-9' do |ba|
			ba.use :input, class: 'form-control chosen-select'
			ba.use :full_error, wrap_with: { tag: :div, class: 'invalid-feedback' }
			ba.use :hint,  wrap_with: { tag: :small, class: 'form-text text-muted' }
		end
	end

	config.wrappers :check_buttons, tag: :div, class: 'btn-group' do |b|
		b.use :html5
		b.optional :readonly
		b.wrapper tag: :label, class: 'btn btn-outline-primary' do |ba|
			ba.use :input
			ba.use :label_text
		end
	end
end
