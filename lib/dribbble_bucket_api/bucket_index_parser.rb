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
			@buckets = document.css(".bucket-list > li").map do |bucket|
				# parse bucket data from HTML
				id = bucket["class"].gsub(/^bucket\-(\d+)$/, "\1").to_i
				link = bucket.css(".bucket-title a").first
				name = link.text
				url = link["href"]
				# pass data into bucket object
				Bucket.new(id: id, name: name, url: url)
			end
		end
		
		def current_page
			@options[:page] || 1
		end
		
		def total_entries
			@total_entries ||= document.css(".buckets .count").text.to_i
		end
		
		def total_pages
			(total_entries.to_f / 5).ceil
		end
		
		private
		def document
			@document ||= Nokogiri::HTML(@body)
		end
	end
end