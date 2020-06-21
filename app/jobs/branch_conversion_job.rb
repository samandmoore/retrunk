class BranchConversionJob < ApplicationJob
  def perform(branch_conversion)
    # BranchConversion::LockdownOldBranch.new(branch_conversion: branch_conversion).save!
    BranchConversion::CreateNewBranch.new(branch_conversion: branch_conversion).save!
    # BranchConversion::CopyBranchProtectionRules.new(branch_conversion: branch_conversion).save!
    BranchConversion::ChangeDefaultBranch.new(branch_conversion: branch_conversion).save!
    BranchConversion::Complete.new(branch_conversion: branch_conversion).save!
  end
end
