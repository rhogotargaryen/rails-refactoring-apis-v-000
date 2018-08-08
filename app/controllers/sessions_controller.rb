class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    gh = GithubService.new
    resp = gh.authenticate!(ENV["GITHUB_CLIENT"], ENV["GITHUB_SECRET"], params[:code])
    session[:token] = resp
    session[:username] = gh.get_username
  end
  def logout
    session.destroy
    redirect_to root_path
  end
end
