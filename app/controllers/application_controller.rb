# frozen_string_literal: true

class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  configure :development do
    register Sinatra::Reloader
    after_reload { puts 'reloaded' }
  end

  # set folder for templates to ../views, but make the path absolute
  set :views, File.expand_path('../views', __dir__)

  # don't enable logging when running tests
  configure :production, :development do
    enable :logging
  end

  get "/sign_out" do
    session.clear
    redirect '/'
  end

  get "/debugger" do
    debugger
    redirect '/'
  end
end
