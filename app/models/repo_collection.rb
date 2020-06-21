class RepoCollection
  include Enumerable

  attr_reader :repos, :current_page, :more_pages

  delegate :each, to: :repos

  def initialize(repos:, current_page:, more_pages:)
    @repos = repos
    @current_page = current_page&.to_i
    @more_pages = more_pages
  end

  def empty?
    repos.empty?
  end

  def first_page?
    current_page == 1
  end

  def last_page?
    !more_pages
  end

  def previous_page
    current_page - 1
  end

  def next_page
    current_page + 1
  end
end
