# frozen_string_literal: true

class AddDefaultValueToNeedNoticeAttribute < ActiveRecord::Migration[5.0]
  def change
    change_column_default :answers, :need_notice, true
  end
end
