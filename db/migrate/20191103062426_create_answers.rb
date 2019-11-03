class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :phrase
      t.string :answer
      t.string :card_id
      t.boolean :wrong
      t.boolean :need_notice

      t.timestamps
    end
  end
end
