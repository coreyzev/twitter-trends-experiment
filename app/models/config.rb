class Config < ActiveRecord::Base
  belongs_to :location
  serialize :twitter_place

  def after_save
    location = get_location(self.address)
    self.latitude = location.latitude
    self.longitude = location.longitude
    self.twitter_place = $twitter_client.trends_closest({:lat => self.latitude, :long => self.longitude}).first
  end

  def get_location(query)
    if loc = Geocoder.search(query).first
    else
      loc = Geocoder.search('173.247.200.165').first
    end
    if location = Location.where(:address => loc::address).first
    else
      location = Location.first.update(address: loc::address, latitude: loc::latitude, longitude: loc::longitude)
    end

  end
end
