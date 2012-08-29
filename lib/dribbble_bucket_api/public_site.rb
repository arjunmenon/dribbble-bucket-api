require "httparty"
require_relative "bucket_index_parser"

module DribbbleBucketApi
	class PublicSite
		include HTTParty
		base_uri "dribbble.com"
		
		def user_buckets(options)
			response = load_user_buckets(options)
			# ensure it was a successful response
			unless response.code == 200
				raise StandardError, %Q(
					Response returned #{response.code}
					Body:
					#{response.body}
				)
			end
			# return the object
			BucketIndexParser.new(response.body, options)
		end
		
		private
		def load_user_buckets(options)
			# ensure we have a username
			unless options[:username]
				raise ArgumentError, %Q(
					Options hash must contain :username
					e.g: PublicDribbbleSite.new.user_buckets(username: "ryantownsend")
				)
			end
			# perform the request
			self.class.get("/#{options[:username]}/buckets?page=#{options[:page] || 1}")
		end
	end
end