require 'rubygems'
require 'bundler'
require 'pathname'
require 'fileutils'

Bundler.require
include FileUtils

ROOT        = Pathname(File.dirname(__FILE__))
BUILD_DIR   = ROOT.join("public")
SOURCE_DIR  = ROOT.join("app")
ASSETS      = %w{ application.js application.css }

desc 'Compile assets to build directory'
task :compile => :cleanup do
  time_start = Time.now
  Dir.mkdir BUILD_DIR if !File.exists?(BUILD_DIR)
  sprockets = Sprockets::Environment.new
  sprockets.css_compressor = YUI::CssCompressor.new
  sprockets.js_compressor  = Uglifier.new
  sprockets.append_path(ROOT.join('app').to_s)
  sprockets.append_path(ROOT.join('css').to_s)
  sprockets.append_path(ROOT.join('vendor').to_s)
  ASSETS.each do |asset_name|
    puts "Compiling #{asset_name}"
    asset = sprockets[asset_name]
    prefix, basename = asset.pathname.to_s
    asset.write_to BUILD_DIR.join(asset_name)
  end
  time_end = Time.now
  puts "Assets compiled in #{(time_end - time_start).to_i} seconds"
end

desc 'Clean up build and package directories'
task :cleanup do
  puts "Cleaning up build directory..."
  FileUtils.rm_r("#{BUILD_DIR}/.", force: true)
end
