# frozen_string_literal: true

# This service checks authorization by oauth 

class CheckOauthService < Callable
  def initialize(user)
    @user = user
  end

  def call
    @user.authentications.present?
  end
end
