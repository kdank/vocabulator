class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :vocab_word_id
      t.integer :attempt_id
      t.timestamps
    end
  end
end
