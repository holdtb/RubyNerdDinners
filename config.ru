require 'rubygems'
require 'sinatra'
require 'bundler'
require './app'

require 'pry'
require 'pry-byebug'

Bundler.require

root = ::File.dirname(__FILE__)
require ::File.join(root, 'app')
run NerdDinner.new

