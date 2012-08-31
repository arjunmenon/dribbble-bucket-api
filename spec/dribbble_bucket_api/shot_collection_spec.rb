require "spec_helper"
require_relative "../../lib/dribbble_bucket_api/shot_collection"

describe DribbbleBucketApi::ShotCollection do
	subject { DribbbleBucketApi::ShotCollection }

	describe "::retrieve" do
		context "with a username & bucket" do
			it "should return an instance of a collection" do
				result = subject.retrieve({
					username: "ryantownsend",
					bucket_id: 44001
				})
				expect(result).to be_kind_of subject
			end
		end
	end
end