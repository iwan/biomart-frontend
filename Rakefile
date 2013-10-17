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

CLEAN.include "app/**/*.js"
CLEAN.include "spec/**/*.js"
FileList['**/*.coffee'].ext('js').each do |f|
  task :coffee => f
end

Capybara::Jasmine::TestTask.new "spec" => "coffee" do |t|
  Capybara.javascript_driver = :poltergeist
  t.lib_files = FileList[
    "vendor/jquery-*.js",
    "vendor/underscore.js",
    "vendor/backbone.js",
    "vendor/**/*.js",
    "app/bmf.js",
    "app/**/*.js",
    "spec/SpecHelper.js"
  ].uniq
  t.spec_files = FileList["spec/**/*Spec.js"]
end

task :test => ['coffee', 'spec']
task :default => :test

