# https://nickcharlton.net/posts/structuring-sinatra-applications.html

# config.ru
require "rubygems"
require "bundler"
Bundler.require
require "dotenv/load"

require "sinatra/base"
require "sinatra/reloader"
require "byebug"

require_relative "app/helpers/application_helper"
require_relative "app/controllers/application_controller"
require_relative "app/controllers/github_auth_controller"


use Rack::Session::Cookie, secret: ENV['SECRET_KEY_BASE']
use OmniAuth::Builder do
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'], scope: "user,repo"
end

map('/auth/github') { run GithubAuthController }
map('/') { run ApplicationController }
