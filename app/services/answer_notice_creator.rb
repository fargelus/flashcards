# frozen_string_literal: true

# Service for define notice text when answer was checked

class AnswerNoticeCreator < ApplicationService
  def initialize(answer)
    @answer = answer
  end

  def call
    notice_done
    define_notice_text
  end

  private

  def notice_done
    @answer.need_notice = false
    @answer.save!
  end

  def define_notice_text
    @answer.wrong ? I18n.t(:wrong_answer) : I18n.t(:correct_answer)
  end
end
