require_relative "bucket_collection"

module DribbbleBucketApi
	class Connection < Struct.new(:username)
		def buckets(options = {})
			load_collection(options.merge(connection: self))
		end
		
		private
		def load_collection(options)
			BucketCollection.retrieve(options)
		end
	end
end