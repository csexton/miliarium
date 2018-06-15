# frozen_string_literal: true

require_relative "application_controller"

class GithubAuthController < ApplicationController
  CLIENT_ID = ENV["CLIENT_ID"]
  CLIENT_SECRET = ENV["CLIENT_SECRET"]

  get "/debugger" do
    debugger
    redirect '/'
  end

  # access this to request a token from facebook.
  get "/" do
    url = "https://github.com/login/oauth/authorize?client_id=#{CLIENT_ID}&redirect_uri=https://#{request.host}/auth/github/callback"
    redirect url
  end

  # If the user authorizes it, this request gets your access token
  # and makes a successful api call.
  get "/callback" do
    code = params["code"]
    uri = URI.parse("https://github.com/login/oauth/access_token")
    form = {
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET,
      code: code
    }
    res = Net::HTTP.post_form(uri, form)
    params = URI.decode_www_form(res.body).to_h

    session[:access_token] = params["access_token"]

    redirect "/"
  end

  def redirect_uri(path = '/auth/github/callback', query = nil)
    uri = URI.parse(request.url)
    uri.path  = path
    uri.query = query
    uri.to_s
  end
end
