class BranchConversion::Start
  include ActiveModel::Model

  attr_reader :branch_conversion

  delegate :transaction, to: ApplicationRecord

  def save!
    transaction do
      branch_conversion.update!(status: 'started')
      BranchConversionJob.perform_later(branch_conversion)
    end
  end
end
