require 'ffi/aspell'

class SpellCheck
  def initialize(word)
  	@speller = FFI::Aspell::Speller.new('en_US')
  	@word = word
  end

  def perform
  	if @speller.correct?(@word)
      correct_response
    else
      @suggestions = @speller.suggestions(@word)
      incorrect_response
    end
  end

  private

  def correct_response
    {spelling: "#{@word} is Correctly Spelled"}
  end

  def incorrect_response
    {
      spelling: "#{@word} is Incorrectly Spelled or does not exist",
      suggestions: @suggestions
    }
  end
end