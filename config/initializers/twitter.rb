$twitter_client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "BkvHGH62jqeehEzfWx1d7CLU7"
    config.consumer_secret     = "gByoVioXIdRYzadjuHEh2IajhZFtF7D5w1F0tFR1xTsCMkQAFR"
    config.access_token        = "14812836-YraAuPaNZd6ixP5AlHme8TYAx33Ao9VcXGvE3atNV"
    config.access_token_secret = "9a8qZZS4LMykDXcsa3jRWdh7OySg5b1cELOwke6nuy5km"
end

$twitter_stream = Twitter::Streaming::Client.new do |config|
    config.consumer_key        = "BkvHGH62jqeehEzfWx1d7CLU7"
    config.consumer_secret     = "gByoVioXIdRYzadjuHEh2IajhZFtF7D5w1F0tFR1xTsCMkQAFR"
    config.access_token        = "14812836-YraAuPaNZd6ixP5AlHme8TYAx33Ao9VcXGvE3atNV"
    config.access_token_secret = "9a8qZZS4LMykDXcsa3jRWdh7OySg5b1cELOwke6nuy5km"
end