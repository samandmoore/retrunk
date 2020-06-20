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

  private

  def client
    @client ||= Octokit::Client.new(access_token: access_token)
  end
end
