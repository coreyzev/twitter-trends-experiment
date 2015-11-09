$twitter_client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWTR_CONS_KEY"]
    config.consumer_secret     = ENV["TWTR_CONS_SECRET"]
    config.access_token        = ENV["TWT_ACCS_TOKEN"]
    config.access_token_secret = ENV["TWT_ACCS_SECRET"]
end

# $twitter_stream = Twitter::Streaming::Client.new do |config|
# end