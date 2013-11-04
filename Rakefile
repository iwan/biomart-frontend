require 'rubygems'
require 'bundler'
require 'pathname'
require 'fileutils'
require 'capybara-jasmine'
require 'capybara/poltergeist'
require 'rake/clean'

Bundler.require
include FileUtils

ROOT        = Pathname(File.dirname(__FILE__))
PUBLIC_DIR  = ROOT.join("public")
ASSETS      = %w{ application.js application.css }
PATHS       = %w{ app css vendor }

CLEAN.include "spec/*.js"

rule '.js' => '.coffee' do |t|
  puts "Compiling #{t.source} => #{t.name}"
  File.write(t.name, CoffeeScript.compile(File.read(t.source)))
end

FileList['spec/**/*.coffee'].ext('js').each do |f|
  task :coffee => f
end

Capybara::Jasmine::TestTask.new "spec" => "coffee" do |t|
  Capybara.javascript_driver = :poltergeist
  t.lib_files = FileList[
    "public/application.js",
    "spec/spec_helper.js"
  ].uniq
  t.spec_files = FileList["spec/**/*spec.js"]
end

desc 'Compile assets to build directory'
task :compile => :cleanup do
  time_start = Time.now
  Dir.mkdir PUBLIC_DIR if !File.exists?(PUBLIC_DIR)

  sprockets = Sprockets::Environment.new
  sprockets.css_compressor = YUI::CssCompressor.new
  sprockets.js_compressor  = Uglifier.new

  PATHS.each do |path|
    sprockets.append_path(ROOT.join("#{path}").to_s)
  end

  ASSETS.each do |asset_name|
    puts "Compiling #{asset_name}"
    asset = sprockets[asset_name]
    prefix, basename = asset.pathname.to_s
    asset.write_to PUBLIC_DIR.join(asset_name)
  end

  time_end = Time.now
  puts "Assets compiled in #{(time_end - time_start).to_i} seconds"
end

desc 'Clean up precompiled js and css'
task :cleanup do
  puts "Cleaning up build directory..."
  ASSETS.each { |asset| FileUtils.rm_r([PUBLIC_DIR, asset].join("/"), force: true) }
end

task :test => ['coffee', 'spec']
task :default => :test
