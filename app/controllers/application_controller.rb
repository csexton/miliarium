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


  include Warden::GitHub::SSO

  GITHUB_CONFIG = {
    client_id:     ENV['GITHUB_CLIENT_ID']     || 'test_client_id',
    client_secret: ENV['GITHUB_CLIENT_SECRET'] || 'test_client_secret',
    scope:         'user'
  }

  use Warden::Manager do |config|
    config.failure_app = BadAuthentication
    config.default_strategies :github
    config.scope_defaults :default, config: GITHUB_CONFIG
    config.serialize_from_session { |key| Warden::GitHub::Verifier.load(key) }
    config.serialize_into_session { |user| Warden::GitHub::Verifier.dump(user) }
  end

  def verify_browser_session
    if env['warden'].user && !warden_github_sso_session_valid?(env['warden'].user, 10)
      env['warden'].logout
    end
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
