require "nokogiri"
require_relative "bucket"

module DribbbleBucketApi
	class ShotIndexParser
		attr_reader :body

		def initialize(body, options = {})
			@body = body
			@options = options
		end

		def shots
			@shots ||= document.css(".dribbbles > li").map do |shot|
				# parse shot data from HTML
				id = shot["class"].gsub(/^screenshot\-(\d+)$/, "\1").to_i
				img_src = shot.css(".dribbble-img img").first["src"]
				url = "http://dribbble.com" + shot.css("a.dribbble-link").first["href"]
				# pass data into shot object
				Shot.new(id: id, image_teaser_url: img_src, url: url)
			end
		end

		def current_page
			@options[:page] || 1
		end

		def total_entries
			@total_entries ||= document.css(".main h2.section").text.gsub(/^(\d+).*$/, "\1").to_i
		end

		def total_pages
			(total_entries.to_f / 15).ceil
		end

		private
		def document
			@document ||= Nokogiri::HTML(@body)
		end
	end
end