require 'rubygems'
require 'bundler'

require_relative 'app'

Bundler.setup(:default, App.env)
Bundler.require(:default, App.env)

App.boot!
