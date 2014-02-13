require 'sprockets'
require File.dirname(__FILE__) + "/app.rb"

project_root = File.expand_path(File.dirname(__FILE__))

assets = Sprockets::Environment.new(project_root) do |env|
  env.logger = Logger.new(STDOUT)
end

map '/assets/images' do
   run Rack::Directory.new('assets/images')
end

map "/assets" do
  run assets
end

map "/" do
  @root = File.expand_path(File.join(File.dirname(__FILE__), "public"))

  puts "-- root: #{@root}"
  run Proc.new { |env|
    # Extract the requested path from the request
    req = Rack::Request.new(env)
    index_file = File.join(@root, req.path_info, "index.html")

    # env: {"GATEWAY_INTERFACE"=>"CGI/1.1", "PATH_INFO"=>"/", "QUERY_STRING"=>"", "REMOTE_ADDR"=>"127.0.0.1", "REMOTE_HOST"=>"localhost", "REQUEST_METHOD"=>"GET", ...}
    # index_file: /Users/iwan/dev/js/biomart-frontend/public/application.js/index.html

    if File.exists?(index_file)
      # Rewrite to index
      req.path_info += "index.html"
    end
    # Pass the request to the directory app
    Rack::Directory.new(@root).call(env)
  }
end

map "/api" do
  run App
end

