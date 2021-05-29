# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook google_oauth2 github]
  enum provider: [:default, :google_oauth2, :facebook, :github]

  has_many :accounts, dependent: :destroy
  has_many :transactions, through: :accounts

  def self.from_provide(form)
    # return nil if User.find_by(uid: form[:uid]).present?
    create_with(email: form[:email] ? form[:email] : "",
                full_name: form[:full_name],
                avatar_url: form[:avatar_url],
                provider: form[:provider]).find_or_create_by!(uid: form[:uid])
  end
end
