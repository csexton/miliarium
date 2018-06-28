# frozen_string_literal: true

require_relative "application_controller"

class ProfileController < ApplicationController
  get "/" do
    u = User.find(id: session[:user_id])
    client = Octokit::Client.new(access_token: u.github_access_token) if u

    slim :index, locals: { client: client }
  end
end
