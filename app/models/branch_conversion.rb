class BranchConversion < ApplicationRecord
  include SteadyState

  belongs_to :user

  validates :repo_full_name, :old_default_branch_name, :new_default_branch_name, presence: true

  steady_state :status do
    state 'started', default: true

    state 'creating_new_branch', from: 'started'
    state 'new_branch_created', from: 'creating_new_branch'

    state 'changing_default_branch', from: 'new_branch_created'
    state 'default_branch_changed', from: 'changing_default_branch'

    state 'completed', from: 'default_branch_changed'

    state 'unprotecting_old_default_branch', from: 'completed'
    state 'old_default_branch_unprotected', from: 'unprotecting_old_default_branch'

    state 'deleting_old_default_branch', from: 'old_default_branch_unprotected'
    state 'old_default_branch_deleted', from: 'deleting_old_default_branch'

    state 'cleanup_completed', from: 'old_default_branch_deleted'
  end

  def old_default_branch_exists?
    github.branch_exists?(repo_full_name: repo_full_name, branch_name: old_default_branch_name)
  end

  private

  def github
    @github ||= Github.for_user(user)
  end
end
