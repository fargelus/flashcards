# Controller for user session destroy
# frozen_string_literal: true

module Dashboard
  class UserSessionsController < ApplicationController
    def destroy
      logout
      redirect_to root_path
    end
  end
end
