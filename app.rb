require 'sinatra'
require 'httparty'

class App < Sinatra::Base

  get "/marts" do
    response = HTTParty.get("http://central.biomart.org/martservice/marts.json")
    #puts response.body, response.code, response.message, response.headers.inspect
    "#{response.body}"
  end
end
