class Api::SpellChecksController < ApplicationController
  def show
    @word = SpellCheck.new(params[:name])
    render json: @word.perform
  end
end