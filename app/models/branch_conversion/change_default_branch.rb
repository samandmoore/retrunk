class BranchConversion::ChangeDefaultBranch
  include ActiveModel::Model

  attr_reader :branch_conversion

  def save!
    github = Github.for_user(branch_conversion.user)

    branch_conversion.update!(status: 'changing_default_branch')

    github.change_default_branch(
      repo_full_name: branch_conversion.repo_full_name,
      branch_name: branch_conversion.new_default_branch_name
    )

    branch_conversion.update!(status: 'default_branch_changed')
  end
end
