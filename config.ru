require 'rubygems'
require 'sinatra'
require 'bundler'
require './app'

Bundler.require

map "/" do
  run NerdDinner
end
