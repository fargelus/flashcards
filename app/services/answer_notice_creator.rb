# frozen_string_literal: true

# Service for define notice text when answer was checked

class AnswerNoticeCreator < ApplicationService
  def initialize(answer)
    @answer = answer
  end

  def call
    notice_done
    define_notice
  end

  private

  def notice_done
    @answer.need_notice = false
    @answer.save!
  end

  def define_notice
    notice = {
      'status': :notice,
      'text': I18n.t(:correct_answer)
    }
    notice['text'] = I18n.t(:typos_answer) if @answer.typo
    notice['status'] = :alert if @answer.wrong
    notice['text'] = I18n.t(:wrong_answer) if @answer.wrong

    notice
  end
end
