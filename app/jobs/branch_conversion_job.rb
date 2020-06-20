class BranchConversionJob < ApplicationJob
  def perform(branch_conversion)
    BranchConversion::CreateNewBranch.new(branch_conversion: branch_conversion).save!
    BranchConversion::ChangeDefaultBranch.new(branch_conversion: branch_conversion).save!
  end
end
