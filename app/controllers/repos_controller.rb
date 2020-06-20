class ReposController < ApplicationController
  def index
    repos = Github.for_user(current_user).repos
    render :index, locals: { repos: repos }
  end
end
