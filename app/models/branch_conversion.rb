class BranchConversion < ApplicationRecord
  belongs_to :user

  validates :repo_full_name, :old_default_branch_name, :new_default_branch_name, presence: true

  steady_state :status do
    state 'started', default: true

    state 'creating_new_branch', from: 'started'
    state 'new_branch_created', from: 'creating_new_branch'

    state 'changing_default_branch', from: 'new_branch_created'
    state 'default_branch_changed', from: 'changing_default_branch'

    state 'completed', from: 'default_branch_changed'
  end
end
