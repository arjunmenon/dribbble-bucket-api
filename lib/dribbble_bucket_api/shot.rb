require "ostruct"
require_relative "official_api"

module DribbbleBucketApi
	class Shot
		def initialize(attrs = {})
			@attrs = attrs
			# ensure we have an id
			unless @attrs.has_key?(:id) && @attrs[:id]
				raise ArgumentError, "Shot must be initialized with an id"
			end
		end

		def method_missing(method, *args, &block)
			# if attrs has the method, and this is an accessor
			if @attrs.has_key?(method.to_sym) && args.empty? && !block_given?
				@attrs[method.to_sym]
			# if we haven't requested the data yet, and this is a accessor
			elsif !requested_full_data? && args.empty? && !block_given?
				# request the data, then resubmit the method
				request_full_data && send(method)
			else
				super
			end
		end
		
		def request_full_data
			@requested_full_data = true
			properties = OfficialApi.new.get_shot_properties(id)
			@attrs.merge!(properties)
		end
		
		def requested_full_data?
			!!@requested_full_data
		end
	end
end