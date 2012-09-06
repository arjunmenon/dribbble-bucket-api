require "nokogiri"
require_relative "bucket"

module DribbbleBucketApi
	class BucketIndexParser
		attr_reader :body

		def initialize(body, options = {})
			@body = body
			@options = options
		end
		
		def buckets
			@buckets ||= document.css(".bucket-list > li").map do |bucket|
				# parse bucket data from HTML
				id = bucket["class"] =~ /^bucket\-(\d+)$/ && $1.to_i
				name = bucket.css(".bucket-title a").first.text
				# pass data into bucket object
				Bucket.new(id: id, name: name, username: username)
			end
		end
		
		def current_page
			@options[:page] || 1
		end
		
		def total_entries
			@total_entries ||= document.css(".buckets .count").text.to_i
		end
		
		def total_pages
			total_entries > 0 ? (total_entries.to_f / 5).ceil : 0
		end
		
		private
		def username
			@options[:username]
		end
		
		def document
			@document ||= Nokogiri::HTML(@body)
		end
	end
end