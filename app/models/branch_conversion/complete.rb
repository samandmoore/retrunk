class BranchConversion::Complete
  include ActiveModel::Model

  attr_accessor :branch_conversion

  def save!
    branch_conversion.update!(status: 'completed')
  end
end
