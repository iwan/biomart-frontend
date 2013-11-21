require 'sinatra'
require 'httparty'
require 'json'
require_relative 'lib/xml/parser'

class App < Sinatra::Base

  get "/marts" do
    response = HTTParty.get("http://central.biomart.org/martservice/marts.json")
    response.body
  end

  get "/config" do
    content_type :json
    parser = XML::Parser.new
    content = (parser.stream).to_json
  end
end
