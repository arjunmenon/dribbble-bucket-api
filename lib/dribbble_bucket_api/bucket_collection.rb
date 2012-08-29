require_relative "public_site"

module DribbbleBucketApi
	class BucketCollection < Array
		def self.retrieve(options)
			# ensure we have a connection
			unless options[:connection]
				raise ArgumentError, %Q(
					Options hash must contain :connection
					e.g: DribbbleBucketApi::BucketCollection.load(connection: connection)
				)
			end
			# load the username
			username = options[:connection].username
			# load the page
			response = PublicSite.new.user_buckets({
				username: username,
				page: options[:page] || 1
			})
			# create the new array
			new(response.buckets).tap do |arr|
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