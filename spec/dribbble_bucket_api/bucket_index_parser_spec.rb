require_relative "../../lib/dribbble_bucket_api/bucket_index_parser"

describe DribbbleBucketApi::BucketIndexParser do
	let(:body) do
		%Q(
			<div class="buckets">
				Buckets
				<span class="count">29</span>
			</div>
			
			<ol class="bucket-list">
				<li class="bucket-12345">
					<span class="bucket-title">
						<a href="#loc">Awesome</a>
					</span>
				</li>
				<li class="bucket-67890">
					<span class="bucket-title">
						<a href="#loc">Awesome</a>
					</span>
				</li>
				<li class="bucket-98760">
					<span class="bucket-title">
						<a href="#loc">Awesome</a>
					</span>
				</li>
				<li class="bucket-54321">
					<span class="bucket-title">
						<a href="#loc">Awesome</a>
					</span>
				</li>
				<li class="bucket-12093">
					<span class="bucket-title">
						<a href="#loc">Awesome</a>
					</span>
				</li>
			</ol>
		)
	end
	
	let(:connection) do
		mock("connection", username: "ryantownsend")
	end
	
	let(:options) do
		{
			page: 2,
			connection: connection
		}
	end
	
	subject do
		DribbbleBucketApi::BucketIndexParser.new(body, options)
	end
	
	describe "#buckets" do
		it "should return an item for each bucket in the list" do
			expect(subject.buckets.size).to eq 5
		end
		
		it "should return Bucket instances" do
			subject.buckets.each do |bucket|
				expect(bucket).to be_kind_of DribbbleBucketApi::Bucket
			end
		end
	end
	
	describe "#current_page" do
		it "should return the options page" do
			expect(subject.current_page).to eq 2
		end
	end
	
	describe "#total_entries" do
		it "should return count from the HTML document" do
			expect(subject.total_entries).to eq 29
		end
	end
	
	describe "#total_pages" do
		it "should return the total / 5" do
			expect(subject.total_pages).to eq 6
		end
	end
end