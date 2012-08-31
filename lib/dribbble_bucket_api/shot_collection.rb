require_relative "public_site"
require_relative "shot"

module DribbbleBucketApi
	class ShotCollection < Array
		def self.retrieve(options)
			# load the page
			response = PublicSite.new.bucket_contents({
				page: 1
			}.merge(options))
			# create the new array
			new(response.shots).tap do |arr|
				arr.total_entries = response.total_entries
				arr.total_pages = response.total_pages
				arr.current_page = response.current_page
			end
		end

		attr_accessor :total_entries, :total_pages, :current_page

		def next_page
			current_page + 1
		end

		def prev_page
			[current_page - 1, 1].max
		end
	end
end