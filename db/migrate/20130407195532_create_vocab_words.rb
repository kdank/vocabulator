class CreateVocabWords < ActiveRecord::Migration
  def change
    create_table :vocab_words do |t|
      t.string :name
      t.string :word_type
      t.string :definition
      t.timestamps
    end
  end
end
