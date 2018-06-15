require 'rubygems'
require 'bundler'
Bundler.require
require './server.rb'
run Sinatra::Application

# https://nickcharlton.net/posts/structuring-sinatra-applications.html

# config.ru
require 'rubygems'
require 'bundler'
Bundler.require

# pull in the helpers and controllers
Dir.glob('./app/{helpers,controllers}/*.rb').each { |file| require file }

# map the controllers to routes
map('/auth/github') { run GithubAuthController }
map('/') { run ApplicationController }
