require_relative "../lib/dribbble_bucket_api"

describe DribbbleBucketApi do
	describe "::connect" do
		context "when no username is provided" do
			it "should raise an exception" do
				expect {
					subject.connect(username: nil)
				}.to raise_error(ArgumentError)
			end
		end
		
		context "when a username is provided" do
			it "should return a connection object containing the username" do
				connection = subject.connect(username: "ryantownsend")
				expect(connection.username).to eq("ryantownsend")
			end
		end
	end
end