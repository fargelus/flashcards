# frozen_string_literal: true

class CompareFieldsValidator < ActiveModel::Validator
  def validate(record)
    if record.original_text.casecmp?(record.translated_text)
      record.errors[:original_text] << I18n.t('orig_text_trn_text_match_err')
    end
  end
end
