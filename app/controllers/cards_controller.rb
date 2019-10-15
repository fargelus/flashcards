# Controller for cards resources
# frozen_string_literal: true

class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end
end
