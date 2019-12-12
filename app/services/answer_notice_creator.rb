# frozen_string_literal: true

# Service for showing notice with answer checking result

class AnswerNoticeCreator < ApplicationService
  def initialize(answer, flash)
    @answer = answer
    @flash = flash
  end

  def call
    make_notice if @answer.need_notice
  end

  private

  def make_notice
    define_notice_text
    notice_done
  end

  def define_notice_text
    @flash.now[:notice] = if @answer.wrong
                            I18n.t(:wrong_answer)
                          else
                            I18n.t(:correct_answer)
                          end
  end

  def notice_done
    @answer.need_notice = false
    @answer.save!
  end
end
