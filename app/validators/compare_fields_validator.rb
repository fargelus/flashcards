# frozen_string_literal: true

class CompareFieldsValidator < ActiveModel::Validator
  def validate(record)
    original_text = record.original_text
    translated_text = record.translated_text

    is_orig_string = original_text.is_a? String
    is_tr_string = translated_text.is_a? String
    is_allowed_for_cmp =  is_orig_string && is_tr_string

    if is_allowed_for_cmp && record.original_text.casecmp?(record.translated_text)
      record.errors[:original_text] << I18n.t('orig_text_trn_text_match_err')
    end
  end
end
