class ConversionsController < ApplicationController
  def new
    repo = Github.for_user(current_user)
      .repo_by_name(owner: name_params[:owner], name: name_params[:name])

    render :new, locals: { repo: repo }
  end

  private

  def name_params
    params.permit(:owner, :name)
  end
end
