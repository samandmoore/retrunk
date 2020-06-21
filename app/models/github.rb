class Github
  attr_reader :access_token

  def initialize(access_token:)
    @access_token = access_token
  end

  def self.for_user(user)
    new(access_token: user.github_oauth_token)
  end

  def repos(page: nil)
    repos = if page.present?
      client.repos(nil, page: page)
    else
      client.repos
    end
    more_pages = client.last_response.rels[:next].present?
    current_page = page.presence || 1
    RepoCollection.new(
      repos: repos.map { |r| Repo.new(repo: r) },
      current_page: current_page,
      more_pages: more_pages
    )
  end

  def repo_by_name(owner:, name:)
    Repo.new(repo: client.repo("#{owner}/#{name}"))
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

  def branch_exists?(repo_full_name:, branch_name:)
    client.branch(
      repo_full_name,
      branch_name
    )
    true
  rescue Octokit::NotFound
    false
  end

  def delete_branch(repo_full_name:, branch_name:)
    client.delete_branch(
      repo_full_name,
      branch_name
    )
    true
  rescue Octokit::UnprocessableEntity => e
    e.message =~ /Reference does not exist/
  end

  def unprotect_branch(repo_full_name:, branch_name:)
    client.unprotect_branch(
      repo_full_name,
      branch_name
    )
    true
  rescue Octokit::ClientError => e
    e.message =~ /Branch not protected/
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: access_token)
  end
end
