require_relative "../../lib/dribbble_bucket_api/bucket_collection"

describe DribbbleBucketApi::BucketCollection do
	subject { DribbbleBucketApi::BucketCollection }
	
	let(:connection) do
		mock("connection", username: "ryantownsend")
	end
	
	describe "::retrieve" do
		context "with a connection" do
			it "should return an instance of a collection" do
				result = subject.retrieve(connection: connection)
				expect(result).to be_kind_of subject
			end
		end

		context "without a connection" do
			it "should raise an exception" do
				expect {
					subject.retrieve(connection: nil)
				}.to raise_error(ArgumentError)
			end
		end
	end
end