# https://nickcharlton.net/posts/structuring-sinatra-applications.html

# config.ru
require "rubygems"
require "bundler"
Bundler.require
require "dotenv/load"

require "sinatra/base"
require "sinatra/reloader"
require "byebug"

Dir.glob('./app/{helpers,controllers}/*.rb').each { |file| require file }

use Rack::Session::Cookie, secret: ENV['SECRET_KEY_BASE']
use OmniAuth::Builder do
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
end

map('/auth/github') { run GithubAuthController }
map('/') { run ApplicationController }
