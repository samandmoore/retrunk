class BranchConversion::DeleteOldBranch
  include ActiveModel::Model

  attr_accessor :branch_conversion

  def save!
    github = Github.for_user(branch_conversion.user)

    branch_conversion.update!(status: 'deleting_old_default_branch')

    github.delete_branch(
      repo_full_name: branch_conversion.repo_full_name,
      branch_name: branch_conversion.old_default_branch_name
    )

    branch_conversion.update!(status: 'old_default_branch_deleted')
  end
end
