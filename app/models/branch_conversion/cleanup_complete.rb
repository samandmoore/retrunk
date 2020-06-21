class BranchConversion::CleanupComplete
  include ActiveModel::Model

  attr_accessor :branch_conversion

  def save!
    branch_conversion.update!(status: 'cleanup_completed')
  end
end
