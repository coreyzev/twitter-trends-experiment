class Config < ActiveRecord::Base
  belongs_to :location
  after_save :add_twitter
  serialize :twitter_place

  private
    def add_twitter
      location = Geocoder.search(self.address).first
      twitter_place = $twitter_client.trends_closest({:lat => location.latitude, :long => location.longitude}).first
      self.update_columns(:twitter_place => twitter_place)
    end
end
