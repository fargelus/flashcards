# frozen_string_literal: true

class TyposController < ApplicationController
  def show
    abort flash.inspect
    abort 'HELLO from typos'
  end
end
