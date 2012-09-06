require "spec_helper"
require_relative "../../lib/dribbble_bucket_api/shot_index_parser"

describe DribbbleBucketApi::ShotIndexParser do
	let(:body) do
		%Q(
			<body>
				<div id="main">
					<h2 class="section">212 Shots</h2>
					<ol class="dribbbles group">
						<li id="screenshot-693587" class="group">
							<div class="dribbble">
								<div class="dribbble-shot">
									<div class="dribbble-img">
										<a href="/shots/693587-Timeline" class="dribbble-link"><img alt="Screen_shot_2012-08-18_at_6" src="http://dribbble.s3.amazonaws.com/users/2935/screenshots/693587/screen_shot_2012-08-18_at_6.41.47_pm_teaser.png"></a>
										<a href="/shots/693587-Timeline" class="dribbble-over" style="opacity: 0; ">
											<strong>Timeline</strong>
											<em>August 18, 2012</em>
										</a>	
									</div>
								</div>
							</div>
						</li>
			
						<li id="screenshot-693929" class="group">
							<div class="dribbble">
								<div class="dribbble-shot">
									<div class="dribbble-img">
										<a href="/shots/693929-Alternate-Timeline" class="dribbble-link"><img alt="teaser" src="http://dribbble.s3.amazonaws.com/users/2935/screenshots/693929/something_teaser.jpg"></a>
										<a href="/shots/693929-Alternate-Timeline" class="dribbble-over">
											<strong>Alternate Timeline</strong>
											<em>August 19, 2012</em>
										</a>
									</div>
								</div>
							</div>
						</li>
					</ol>
				</div>
			</body>
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
		DribbbleBucketApi::ShotIndexParser.new(body, options)
	end

	describe "#shots" do
		it "should return an item for each shot in the list" do
			expect(subject.shots.size).to eq 2
		end

		it "should return Shot instances" do
			subject.shots.each do |shot|
				expect(shot).to be_kind_of DribbbleBucketApi::Shot
			end
		end

		it "should parse the ids correctly" do
			ids = subject.shots.map(&:id)
			expect(ids).to eq [693587, 693929]
		end
		
		it "should parse the extensions correctly" do
			ids = subject.shots.map(&:ext)
			expect(ids).to eq ["png", "jpg"]
		end
		
		it "should parse the image urls correctly" do
			ids = subject.shots.map(&:image_url)
			expect(ids).to eq ["http://dribbble.s3.amazonaws.com/users/2935/screenshots/693587/screen_shot_2012-08-18_at_6.41.47_pm.png", "http://dribbble.s3.amazonaws.com/users/2935/screenshots/693929/something.jpg"]
		end
	end

	describe "#current_page" do
		it "should return the options page" do
			expect(subject.current_page).to eq 2
		end
	end

	describe "#next_page" do
		context "when total_pages > current_page" do
			before do
				subject.stub(:current_page).and_return(2)
				subject.stub(:total_pages).and_return(3)
			end

			it "should return current_page + 1" do
				expect(subject.next_page).to eq 3
			end
		end
		
		context "when total_pages <= current_page" do
			before do
				subject.stub(:current_page).and_return(3)
				subject.stub(:total_pages).and_return(3)
			end
		
			it "should return nil" do
				expect(subject.next_page).to be_nil
			end
		end
	end
	
	describe "#previous_page" do
		context "when current_page > 1" do
			before do
				subject.stub(:current_page).and_return(3)
			end
	
			it "should return current_page - 1" do
				expect(subject.previous_page).to eq 2
			end
		end
		
		context "when current_page <= 1" do
			before do
				subject.stub(:current_page).and_return(1)
			end
		
			it "should return nil" do
				expect(subject.previous_page).to be_nil
			end
		end
	end

	describe "#total_entries" do
		it "should return count from the HTML document" do
			expect(subject.total_entries).to eq 212
		end
	end

	describe "#total_pages" do
		it "should return the total / 15" do
			expect(subject.total_pages).to eq 15
		end
	end
end