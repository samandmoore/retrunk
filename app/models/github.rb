class Github
  attr_reader :access_token

  def initialize(access_token:)
    @access_token = access_token
  end

  def self.for_user(user)
    new(access_token: user.github_oauth_token)
  end

  def repos
    client.repos
  end

  def repo_by_name(owner:, name:)
    client.repo("#{owner}/#{name}")
  end

  def get_branch_current_sha(repo_full_name:, branch_name:)
    client.ref(
      repo_full_name,
      "heads/#{branch_name}"
    ).object.sha
  end

  def create_branch(repo_full_name:, branch_name:, sha:)
    client.create_ref(
      repo_full_name,
      "heads/#{branch_name}",
      sha
    )
  end

  def change_default_branch(repo_full_name:, branch_name:)
    client.edit_repository(
      repo_full_name,
      default_branch: branch_name
    )
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: access_token)
  end
end
