# frozen_string_literal: true

class AnswerNoticeCreator < ApplicationService
  def initialize(answer, flash)
    @answer = answer
    @flash = flash
  end

  def call
    if @answer.need_notice
      define_notice_text
      notice_done
    end
  end

  private

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
