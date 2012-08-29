require "dribbble_bucket_api/version"
require "dribbble_bucket_api/connection"

module DribbbleBucketApi
  def self.connect(options = {})
	  # ensure we have a username
		unless options[:username]
			raise ArgumentError, %Q(
				Options hash must contain :username
				e.g: DribbbleBucketApi.connect(username: "ryantownsend")
			)
		end
		# create the connection
		Connection.new(options[:username])
	end
end
