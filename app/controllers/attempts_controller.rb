class AttemptsController < ApplicationController
  def new
    @attempt = Attempt.new.generate
  end

  def create
    @attempt = Attempt.new(attempts_params)
    if @attempt.save
      flash[:success] = "Attempt Saved"
      redirect_to current_user
    else
      flash[:notice] = "Attempt Was Not Saved"
      redirect_to current_user
    end
  end

  private
    def attempts_params
      params.require(:attempt).permit(:vocab_word_id, :user_id, :user_answer_id, choices_attributes: [:vocab_word_id])
    end
end