require "spec_helper"
require_relative "../../lib/dribbble_bucket_api/public_site"

describe DribbbleBucketApi::PublicSite do
	subject do
		DribbbleBucketApi::PublicSite.new
	end

	describe "#user_buckets" do
		context "when provided with a username" do
			it "should return the remote data" do
				result = subject.user_buckets(username: "ryantownsend")
				expect(result).to be_kind_of(DribbbleBucketApi::BucketIndexParser)
			end
		end
		
		context "when provided with an invalid username" do
			it "should raise an exception" do
				expect {
					subject.user_buckets(username: "h8ahsdIhdasd8q0398d")
				}.to raise_error
			end
		end
		
		context "when not provided with a username" do
			it "should raise an exception" do
				expect {
					subject.user_buckets(username: nil)
				}.to raise_error(ArgumentError)
			end
		end
	end
end