require "ostruct"
require_relative "shot_collection"

module DribbbleBucketApi
	class Bucket < OpenStruct
		def shots(options = {})
			options.merge!(username: username, bucket_id: id)
			ShotCollection.retrieve(options)
		end
	end
end