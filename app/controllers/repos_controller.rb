class ReposController < ApplicationController
  def index
    repos = Github.for_user(current_user).repos(page: page)
    render :index, locals: { repos: repos }
  end

  private

  def page
    params.permit(:page).to_h.fetch(:page, nil)
  end
end
