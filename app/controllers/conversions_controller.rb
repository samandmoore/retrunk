class ConversionsController < ApplicationController
  def show
    github_repo = Github.for_user(current_user)
      .repo_by_name(owner: name_params[:owner], name: name_params[:name])

    repo = RepoOverview.new(repo: github_repo)

    render :show, locals: { repo: repo }
  end

  def create
    repo = Github.for_user(current_user)
      .repo_by_name(owner: name_params[:owner], name: name_params[:name])

    conversion = BranchConversion.new(
      user: current_user,
      repo_full_name: repo.full_name,
      old_default_branch_name: repo.default_branch,
      new_default_branch_name: 'main'
    )

    BranchConversion::Start.new(branch_conversion: conversion).save!

    flash[:info] = "Started conversion for #{repo.full_name}"
    redirect_to repos_path
  end

  private

  def name_params
    params.permit(:owner, :name)
  end
end
