require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  
  currency_hash = parsed_data.fetch("currencies")

  @currency_arr = currency_hash.keys

  erb(:home)
end

get("/:currency") do
  @currency = params.fetch("currency")

  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  
  currency_hash = parsed_data.fetch("currencies")

  @currency_arr = currency_hash.keys
  erb(:currency_list)
end

get("/:currency/:compare") do
  @currency = params.fetch("currency")
  @compare = params.fetch("compare")

  api_url = "http://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@currency}&to=#{@compare}&amount=1"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)

  @result = parsed_data.fetch("result")

  erb(:currency_compare)
end
