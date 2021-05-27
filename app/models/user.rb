# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(form)
    return nil unless form[:email] =~ /@gmail.com\z/

    create_with(uid: form[:uid], full_name: form[:full_name], avatar_url: form[:avatar_url]).find_or_create_by!(email: form[:email])
  end
end
