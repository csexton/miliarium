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

class BadAuthentication < Sinatra::Base
  get '/unauthenticated' do
    status 403
    <<-EOS
      <h2>Unable to authenticate, sorry bud.</h2>
      <p>#{env['warden'].message}</p>
    EOS
  end
end


#map('/auth/github') { run GithubAuthController }
map('/') { run ApplicationController }
