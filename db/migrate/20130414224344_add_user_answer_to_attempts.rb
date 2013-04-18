class AddUserAnswerToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :user_answer_id, :integer 
  end
end
