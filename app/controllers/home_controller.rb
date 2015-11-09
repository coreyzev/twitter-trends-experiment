class HomeController < ApplicationController
  def index
    if params[:location].blank?
        if Rails.env.test? || Rails.env.development?
            get_location(default_location)
        else
            get_location(request.location.address)
        end
    else
        params[:location].each {|l| l = l.to_i } if params[:location].is_a? Array
        get_location(params[:location])
    end
    if @config = Config.first
    else
        @config = Config.create(location: @location, limit: 5, address: @location.address)
    end
    if !Trend.first
        trends = $twitter_client.trends(id = @config.twitter_place.id)
        trends.each do |trend|
            Trend.create(name: trend.name, query: trend.query, url: trend.url)
        end
    elsif Trend.where('updated_at > ?', 15.minutes.ago)
        trends = $twitter_client.trends(id = @config.twitter_place.id)
        trends.each_with_index do |trend, index|
            Trend.update(index + 1, name: trend.name, query: trend.query, url: trend.url)
        end
    end
    @trends = Trend.first(@config.limit)
  end

  def update
    old_address = Config.first.address
    Config.first.update(params.permit(:address, :location_id, :limit))
    config = Config.first
    if old_address != config.address
        location = get_location(config.address)
        config.twitter_place = $twitter_client.trends_closest({:lat => location.latitude, :long => location.longitude}).first
        trends = $twitter_client.trends(id = config.twitter_place.id)
        trends.each_with_index do |trend, index|
            Trend.update(index + 1, name: trend.name, query: trend.query, url: trend.url)
        end
    end
    render partial: 'tweets' , content_type: 'text/html', locals: { trends: Trend.first(config.limit), :@config => Config.first}
  end

  private
    def default_location
      "San Francisco, CA"
    end

    def get_location(query)
        if loc = Geocoder.search(query).first
        else
            loc = Geocoder.search('173.247.200.165').first
        end
        if Location.where(:address => loc::address).first
        else
            Location.first.update(address: loc::address, latitude: loc::latitude, longitude: loc::longitude)
            Location.first
        end
    end
end
