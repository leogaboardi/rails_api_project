require 'open-uri'
require 'json'

puts "Let's get the weather forecast for your address."

puts "What is the address you would like to know the weather for?"
the_address = gets.chomp
url_safe_address = URI.encode(the_address)

# Your code goes below.
url_of_data_we_want = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_address
raw_data = open(url_of_data_we_want).read
parsed_data = JSON.parse(raw_data)
results = parsed_data["results"]
first = results[0]
geometry = first["geometry"]
location = geometry["location"]

# Let's store the latitude in a variable called 'the_latitude',
#   and the longitude in a variable called 'the_longitude'.
the_latitude = location["lat"]
the_longitude = location["lng"]

url ="https://api.forecast.io/forecast/2ea3b5cd98865a722f256df27dc3609e/"+the_latitude.to_s+","+the_longitude.to_s
raw_data = open(url).read
parsed_data = JSON.parse(raw_data)

the_temperature = parsed_data["currently"]["temperature"]

#converting from F to C (just for fun)
the_temperature = ((the_temperature -32) / 1.8).round(1)

#puts the_temperature
the_hour_outlook = parsed_data["hourly"]["summary"]

the_day_outlook = parsed_data["daily"]["data"][0]["summary"]

puts "The current temperature at #{the_latitude}, #{the_longitude} is #{the_temperature} degrees."
puts "The outlook for the next hour is: #{the_hour_outlook}"
puts "The outlook for the next day is: #{the_day_outlook}"


# Ultimately, we want the following line to work when uncommented:

# puts "The current temperature at #{the_address} is #{the_temperature} degrees."
# puts "The outlook for the next hour is: #{the_hour_outlook}"
# puts "The outlook for the next day is: #{the_day_outlook}"
