require 'open-uri'
require 'json'

class ForecastsController < ApplicationController
  def location

    the_address = params[:address]
    #the_address = "5807+S+Woodlawn+Ave"
    url_safe_address = URI.encode(the_address)

    url_of_data_we_want = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_address
    raw_data = open(url_of_data_we_want).read
    parsed_data = JSON.parse(raw_data)
    results = parsed_data["results"]
    first = results[0]
    geometry = first["geometry"]
    location = geometry["location"]

    the_latitude = location["lat"]
    the_longitude = location["lng"]

    @address_name = first["formatted_address"]
    @latitude = the_latitude
    @longitude = the_longitude

    url ="https://api.forecast.io/forecast/2ea3b5cd98865a722f256df27dc3609e/"+the_latitude.to_s+","+the_longitude.to_s
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)

    the_temperature = parsed_data["currently"]["temperature"]

    #converting from F to C (just for fun)
    @temperature = ((the_temperature -32) / 1.8).round(1)

    @hour_outlook = parsed_data["hourly"]["summary"]
    @day_outlook = parsed_data["daily"]["data"][0]["summary"]
  end
end
