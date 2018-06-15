# frozen_string_literal: true
require "sinatra/base"
require "sinatra/reloader"

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

  get "/" do
    slim :index
  end

  get "/debugger" do
    debugger
    redirect '/'
  end
end
