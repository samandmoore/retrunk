class RepoOverview
  def initialize(repo:)
    @repo = repo
  end

  def full_name
    repo.full_name
  end

  def owner
    repo.owner.login
  end

  def name
    repo.name
  end

  def default_branch
    repo.default_branch
  end

  def fork?
    repo.fork?
  end

  def admin?
    repo.permissions.admin?
  end

  def convertible?
    admin? && !(conversion_in_progress? || conversion_complete?)
  end

  def conversion_in_progress?
    conversion.present? && !conversion_complete?
  end

  def conversion_complete?
    conversion&.completed? || false
  end

  def conversion
    @conversion ||= BranchConversion.find_by(repo_full_name: full_name)
  end

  private

  attr_reader :repo
end
