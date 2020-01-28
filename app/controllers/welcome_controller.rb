# frozen_string_literal: true

# Base WelcomeController class without login request

class WelcomeController < ApplicationController
  skip_before_action :require_login
end
