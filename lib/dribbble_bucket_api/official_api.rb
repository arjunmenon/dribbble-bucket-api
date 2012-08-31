require "httparty"
require "multi_json"

module DribbbleBucketApi
	class OfficialApi

		include HTTParty
		base_uri "api.dribbble.com"

		def get_shot_properties(id)
			response = self.class.get("/shots/#{id}.json")
			# ensure it was a successful response
			unless response.code == 200
				raise StandardError, %Q(
					Response returned #{response.code}
					Body:
					#{response.body}
				)
			end
			# return the JSON object as a hash
			MultiJson.load(response.body, symbolize_keys: true)
		end

	end
end