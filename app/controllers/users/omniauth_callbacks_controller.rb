# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      check_user_present("Google")
    end

    def facebook
      check_user_present("Facebook")
    end

    def github
      check_user_present("Github")
    end

    protected

    def after_omniauth_failure_path_for(_scope)
      new_user_session_path
    end

    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || root_path
    end

    private

    def from_provider_params
      @from_provider_params ||= {
        email: auth.info.email,
        full_name: auth.info.name ||= auth.info.nickname,
        uid: auth.uid,
        avatar_url: auth.info.image,
        provider: auth.provider
      }
    end

    def auth
      @auth ||= request.env['omniauth.auth']
    end

    def check_user_present(type)
      user = User.from_provide(from_provider_params)
      if user.present?
        sign_out_all_scopes
        access_token = JsonWebToken.encode({uid: user.uid})
        flash[:success] = t 'devise.omniauth_callbacks.success', kind: type
        flash[:notice] = access_token
        sign_in_and_redirect user, event: :authentication
      else
        flash[:alert] =
          t 'devise.omniauth_callbacks.failure', kind: type, reason: "#{auth.info.email} is not authorized."
        redirect_to new_user_session_path
      end
    end
  end
end
