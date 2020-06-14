class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user && @user.active_for_authentication? && @user.persisted?
      flash[:success] = I18n.t 'devise.omniauth_callbacks.success', kind: 'GitHub'
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = 'Unable to sign in!'
      redirect_to root_path
    end
  end
end
