# frozen_string_literal: true

require "http"
require "byebug"

class GithubAuthController < ApplicationController
  CLIENT_ID = ENV["CLIENT_ID"]
  CLIENT_SECRET = ENV["CLIENT_SECRET"]

  # If the user authorizes it, this request gets your access token
  # and makes a successful api call.
  get "/callback" do
    auth_hash = request.env['omniauth.auth']

    github_token = auth_hash["credentials"]["token"]
    client = Octokit::Client.new(access_token: github_token, per_page: 100)
    debugger
    #code = params["code"]
    #url = "https://github.com/login/oauth/access_token"
    #payload = {
    #  client_id: CLIENT_ID,
    #  client_secret: CLIENT_SECRET,
    #  code: code
    #}

    #http = HTTP.timeout(connect: 15, read: 30)
    #response = http.post(url, json: payload)
    #params = URI.decode_www_form(response.to_s).to_h

    #session[:access_token] = params["access_token"]
    session[:access_token] = auth_hash["credentials"]["token"]

    #redirect "/"
    erb "<a href='/auth/github'>reload</a><br><h1>#{params[:provider]}</h1>
         <pre>#{JSON.pretty_generate(request.env['omniauth.auth'])}</pre>"
  end
end
