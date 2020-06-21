class CleanupsController < ApplicationController
  def create
    repo = Github.for_user(current_user)
      .repo_by_name(owner: name_params[:owner], name: name_params[:name])

    conversion = repo.conversion

    BranchConversion::DeleteOldBranchProtectionRules.new(branch_conversion: conversion).save!
    BranchConversion::DeleteOldBranch.new(branch_conversion: conversion).save!
    BranchConversion::CleanupComplete.new(branch_conversion: conversion).save!

    flash[:info] = "Deleted #{repo.conversion.old_default_branch_name} for #{repo.full_name}"
    redirect_to repos_path
  end

  private

  def name_params
    params.permit(:owner, :name)
  end
end
