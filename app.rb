# /app.rb

require "sinatra"
require "sinatra/reloader"

# Pull in the HTTP class
require "http"

# define a route for the homepage
get("/") do

  # Assemble the API url, including the API key in the query string
  @api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY").chomp}"

  # Use HTTP.get to retrieve the API data
  @raw_response = HTTP.get(@api_url)

  # Get the body of the response as a string
  @raw_string = @raw_response.to_s

  # Convert the string to JSON
  @parsed_data = JSON.parse(@raw_string)

  @currencies = @parsed_data.fetch("currencies")

  # Render a view template
  erb(:homepage)

end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  @api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY").chomp}"
  
   # Use HTTP.get to retrieve the API data
   @raw_response = HTTP.get(@api_url)

   # Get the body of the response as a string
   @raw_string = @raw_response.to_s
 
   # Convert the string to JSON
   @parsed_data = JSON.parse(@raw_string)
 
   @currencies = @parsed_data.fetch("currencies")

  erb(:step_one)

end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  @api_url = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY").chomp}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  
  @raw_response = HTTP.get(@api_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)
  @amount = @parsed_data.fetch("result")
  # Some more code to parse the URL and render a view template.
  erb(:step_two)
end
