# frozen_string_literal: true

require "http"
require "byebug"

require_relative "application_controller"

class GithubAuthController < ApplicationController
  CLIENT_ID = ENV["CLIENT_ID"]
  CLIENT_SECRET = ENV["CLIENT_SECRET"]

  get "/debugger" do
    debugger
    redirect '/'
  end

  get "/unauthenticated" do
    url = "https://github.com/login/oauth/authorize?client_id=#{CLIENT_ID}&redirect_uri=https://#{request.host}/auth/github/callback"
    redirect url
  end

  get "/" do
    redirect "auth/unauthenticated"
  end

  # If the user authorizes it, this request gets your access token
  # and makes a successful api call.
  get "/callback" do
    debugger
    code = params["code"]
    url = "https://github.com/login/oauth/access_token"
    payload = {
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET,
      code: code
    }

    http = HTTP.timeout(connect: 15, read: 30)
    response = http.post(url, json: payload)
    params = URI.decode_www_form(response.to_s).to_h

    session[:access_token] = params["access_token"]

    redirect "/"
  end
end
