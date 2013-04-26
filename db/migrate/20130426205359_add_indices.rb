class AddIndices < ActiveRecord::Migration
  def change
    add_index :attempts, :user_id
    add_index :attempts, :vocab_word_id
    add_index :attempts, :user_answer_id
    add_index :vocab_words, :word_type
  end
end
