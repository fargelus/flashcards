# frozen_string_literal: true

class Welcome::HomeController < ApplicationController
  include ApplicationHelper

  skip_before_action :require_login, only: [:index]

  def index; end
end
