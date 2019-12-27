# frozen_string_literal: true

class CheckOauthService < Callable
  def initialize(user)
    @user = user
  end

  def call
    @user.authentications.present?
  end
end
