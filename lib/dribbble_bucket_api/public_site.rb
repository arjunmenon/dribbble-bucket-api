require "httparty"
require_relative "bucket_index_parser"
require_relative "shot_index_parser"

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
		
		def bucket_contents(options)
			response = load_bucket_contents(options)
			# ensure it was a successful response
			unless response.code == 200
				raise StandardError, %Q(
					Response returned #{response.code}
					Body:
					#{response.body}
				)
			end
			# return the object
			ShotIndexParser.new(response.body, options)
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
		
		def load_bucket_contents(options)
			# ensure we have a username and bucket id
			unless options[:username] && options[:bucket_id]
				raise ArgumentError, %Q(
					Options hash must contain :username and :bucket_id
					e.g: PublicDribbbleSite.new.bucket_contents(username: "ryantownsend", bucket_id: 48172)
				)
			end
			# perform the request
			self.class.get("/#{options[:username]}/buckets/#{options[:bucket_id]}?page=#{options[:page] || 1}")
		end
	end
end