class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_sentry_context

  private

  def set_sentry_context
    Raven.user_context(id: current_user_id)
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
