# bad pluralization on kaminari
module Kaminari
	module Helpers
		module HelperMethods
			extend Kaminari::Helpers::HelperMethods

			def self.included(base)
				base.send :extend, Kaminari::Helpers::HelperMethods
			end

			def page_entries_info(collection, entry_name: nil)
				entry_name = if entry_name
					entry_name.pluralize(collection.size, I18n.locale).titleize
				else
					collection.model_name.human.pluralize(collection.size, I18n.locale).titleize
				end

				if collection.total_pages < 2
					t('helpers.page_entries_info.one_page.display_entries', entry_name: entry_name, count: collection.total_count)
				else
					t('helpers.page_entries_info.more_pages.display_entries', entry_name: entry_name, first: collection.offset_value + 1, last: [collection.offset_value + collection.limit_value, collection.total_count].min, total: collection.total_count)
				end.html_safe
			end
		end
	end
end
