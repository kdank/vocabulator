class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :user_id
      t.integer :vocab_word_id
      t.timestamps
    end
  end
end
