module ApplicationHelper
	def title(title=nil, *args)
		content_for :title do
			if t('.title', default: '').present?
				"#{ t '.title', *args } | #{ t 'globals.app_name' }"
			elsif title.present?
				"#{ title } | #{ t 'globals.app_name' }"
			else
				t 'globals.app_name'
			end
		end
	end

	def display_alert(content_or_options_with_block={}, options={}, &block)
		if block_given?
			options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
			message = capture(&block)
		else
			message = content_tag :p, sanitize(content_or_options_with_block, tags: %w())
		end

		html_class = options.has_key?(:class) ? options.fetch(:class) : 'alert-success'
		html_class += ' alert alert-dismissible fade show'
		html_class = html_class.split.sort.join(' ')

		if message.present?
			content_tag :div, class: html_class do
				content = content_tag :button, class: 'close', data: { dismiss: 'alert' } do
					icon 'close'
				end
				content += message
			end
		end
	end

	def avatar_tag(source, options = {})
		options.merge!({onerror: "this.onerror=null;this.src='#{asset_path('avatar-unknown.jpg')}';"})
		image_tag source, options
	end
end
