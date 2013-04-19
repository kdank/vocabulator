class AttemptsController < ApplicationController
  def new
    @attempt = Attempt.new.generate
  end

  def create
    @attempt = Attempt.new(attempts_params)
    if @attempt.save
      if @attempt.vocab_word == @attempt.user_answer
        flash[:success] = "Correct! the definition of #{@attempt.vocab_word.name} is #{@attempt.vocab_word.definition}"
      else
        flash[:notice] = "Incorrect, the definition of #{@attempt.vocab_word.name} is #{@attempt.vocab_word.definition}"
      end
      redirect_to new_attempt_path
    else
      flash[:notice] = "Something went wrong"
      redirect_to current_user
    end
  end

  private
    def attempts_params
      params.require(:attempt).permit(:vocab_word_id, :user_id, :user_answer_id, choices_attributes: [:vocab_word_id])
    end
end