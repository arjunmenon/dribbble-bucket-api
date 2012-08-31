require "spec_helper"
require_relative "../../lib/dribbble_bucket_api/connection"

describe DribbbleBucketApi::Connection do
	subject do
		DribbbleBucketApi::Connection.new("ryantownsend")
	end

	describe "#buckets" do
		context "when provided with a page" do
			it "should merge the page into a hash with the connection" do
				subject.should_receive(:load_collection).with({
					page: 1,
					connection: subject
				})
				subject.buckets(page: 1)
			end
		end
		
		context "when not provided with a page" do
			it "should load the collection using a hash with the connection" do
				subject.should_receive(:load_collection).with({
					connection: subject
				})
				subject.buckets
			end
		end
	end
end