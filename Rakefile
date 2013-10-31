require 'rubygems'
require 'bundler/setup'
require 'coffee-script'
require 'capybara-jasmine'
require 'capybara/poltergeist'
require 'rake/clean'

rule '.js' => '.coffee' do |t|
  puts "Compiling #{t.source} => #{t.name}"
  File.write(t.name, CoffeeScript.compile(File.read(t.source)))
end

CLEAN.include "app/*.js"
CLEAN.include "app/**/*.js"
CLEAN.include "spec/*.js"
FileList['**/*.coffee'].ext('js').each do |f|
  task :coffee => f
end

Capybara::Jasmine::TestTask.new "spec" => "coffee" do |t|
  Capybara.javascript_driver = :poltergeist
  t.lib_files = FileList[
    "vendor/modernizr-*.js",
    "vendor/jquery-*.js",
    "vendor/lodash.js",
    "vendor/backbone.js",
    "vendor/*.js",
    "app/namespace.js",
    "app/**/*.js",
    #"app/models/*.js",
    #"app/collections/*.js",
    #"app/views/*.js",
    "app/*.js",
    "spec/spec_helper.js"
  ].uniq
  t.spec_files = FileList["spec/**/*spec.js"]
end

task :test => ['coffee', 'spec']
task :default => :test

