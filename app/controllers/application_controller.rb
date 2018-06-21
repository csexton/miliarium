# frozen_string_literal: true

class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  configure :development do
    register Sinatra::Reloader
    after_reload { puts 'reloaded' }
  end

  enable :sessions

  # set folder for templates to ../views, but make the path absolute
  set :views, File.expand_path('../views', __dir__)

  # don't enable logging when running tests
  configure :production, :development do
    enable :logging
  end

  get '/profile' do
    verify_browser_session
    env['warden'].authenticate!
    slim :index, locals: { client: client }
  end

  get '/login' do
    verify_browser_session
    env['warden'].authenticate!
    redirect '/'
  end

  get '/logout' do
    env['warden'].logout
    redirect '/'
  end


  get "/" do
    "ohai"
    #  debugger
    #  env['warden'].authenticate!
    #  client = Octokit::Client.new(access_token: session[:access_token])
  end

  get "/debugger" do
    debugger
    redirect '/'
  end
end
