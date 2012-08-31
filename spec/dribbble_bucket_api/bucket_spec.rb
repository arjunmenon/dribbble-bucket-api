require "spec_helper"
require_relative "../../lib/dribbble_bucket_api/bucket"

describe DribbbleBucketApi::Bucket do
	let(:username) { "ryantownsend" }
	let(:id) { 44001 }

	subject do
		DribbbleBucketApi::Bucket.new({
			username: username,
			id: id
		})
	end

	describe "#shots" do
		it "should return a ShotCollection instance" do
			expect(subject.shots).to be_kind_of DribbbleBucketApi::ShotCollection
		end
	end
end