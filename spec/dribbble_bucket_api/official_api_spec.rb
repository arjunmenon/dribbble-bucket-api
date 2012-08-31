require "spec_helper"
require_relative "../../lib/dribbble_bucket_api/official_api"

describe DribbbleBucketApi::OfficialApi do
	subject do
		DribbbleBucketApi::OfficialApi.new
	end

	describe "#get_shot_properties" do
		context "when provided with a valid id" do
			it "should return a hash of properties" do
				result = subject.get_shot_properties(156734)
				expect(result).to be_kind_of(Hash)
			end
		end

		context "when provided with an invalid id" do
			it "should raise an exception" do
				expect {
					subject.get_shot_properties("abc")
				}.to raise_error
			end
		end
	end
end