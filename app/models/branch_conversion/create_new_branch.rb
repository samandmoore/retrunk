class BranchConversion::CreateNewBranch
  include ActiveModel::Model

  attr_accessor :branch_conversion

  def save!
    github = Github.for_user(branch_conversion.user)
    current_sha = github.get_branch_current_sha(
      repo_full_name: branch_conversion.repo_full_name,
      branch_name: branch_conversion.old_default_branch_name
    )

    branch_conversion.update!(status: 'creating_new_branch')

    github.create_branch(
      repo_full_name: branch_conversion.repo_full_name,
      branch_name: branch_conversion.new_default_branch_name,
      sha: current_sha
    )

    branch_conversion.update!(status: 'new_branch_created')
  end
end
