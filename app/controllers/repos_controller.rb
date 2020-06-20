class ReposController < ApplicationController
  def index
    repos = Github.for_user(current_user).repos.map { |r| RepoOverview.new(repo: r) }
    render :index, locals: { repos: repos }
  end
end
