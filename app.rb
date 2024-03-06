require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)

  erb(:home)
end

get("/:currency") do
  @currency = params.fetch("currency")

  erb(:currency_list)
end

get("/:currency/:compare") do
  @currency = params.fetch("currency")
  @compare = params.fetch("compare")

  erb(:currency_compare)
end
