# DribbbleBucketApi

This gem provides an unofficial API for browsing buckets on Dribbble and their contents.

## Installation

Add this line to your application's Gemfile:

    gem 'dribbble-bucket-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dribbble-bucket-api

## Usage

    username = "your_username"
    connection = DribbbleBucketApi.connect(username: username)
    
    # loading buckets
    buckets = connection.buckets(page: 1) # => DribbbleBucketApi::BucketCollection
    buckets.total_pages # => 2
    buckets.total_entries # => 7
    buckets.current_page # => 1
    buckets.next_page # => 2
    buckets.previous_page # => nil
    
    buckets.each do |bucket| # => DribbbleBucketApi::Bucket
      puts bucket.name
      puts bucket.description
      
      # loading shots
      shots = bucket.shots(page: 1) # => DribbbleBucketApi::ShotCollection
      shots.each do |shot| # => DribbbleBucketApi::Shot
        puts shot.title
        puts shot.image_url
        # full list of attributes can be found here:
        # http://dribbble.com/api#get_shot
      end
      
    end
    

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
