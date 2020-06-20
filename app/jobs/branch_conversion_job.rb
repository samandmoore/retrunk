class BranchConversionJob < ApplicationJob
  def perform(branch_conversion)
    # BranchConversion::LockdownOldBranch.new(branch_conversion: branch_conversion).save!
    BranchConversion::CreateNewBranch.new(branch_conversion: branch_conversion).save!
    # BranchConversion::CopyBranchProtectionRules.new(branch_conversion: branch_conversion).save!
    BranchConversion::ChangeDefaultBranch.new(branch_conversion: branch_conversion).save!
    # BranchConversion::SendUpdateInstructions.new(branch_conversion: branch_conversion).save!

    # perhaps delay this for a few days so no one can push it back up?
    # BranchConversion::DeleteOldBranch.new(branch_conversion: branch_conversion).save!
    BranchConversion::Complete.new(branch_conversion: branch_conversion).save!
  end
end
