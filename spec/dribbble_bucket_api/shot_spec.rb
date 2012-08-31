require "spec_helper"
require_relative "../../lib/dribbble_bucket_api/shot"

describe DribbbleBucketApi::Shot do
	let(:id) { 156734 }

	subject do
		DribbbleBucketApi::Shot.new({ id: id })
	end

	describe "#image_url" do
		context "when the image_url has not yet been loaded" do
			it "should return a string" do
				expect(subject.image_url).to match /^https?\:\/\//
			end
		end
	end
	
	describe "#a_random_method" do
		it "should return method missing" do
			expect {
				subject.a_random_method
			}.to raise_error(NoMethodError)
		end
	end
end