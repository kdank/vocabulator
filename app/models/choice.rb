class Choice < ActiveRecord::Base
  belongs_to :attempt
  belongs_to :vocab_word
end
