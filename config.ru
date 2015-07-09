require 'rubygems'
require 'sinatra'
require 'bundler'
require './app'

require 'pry'
require 'pry-byebug'

Bundler.require

map "/" do
  run NerdDinner
end
