class Attempt < ActiveRecord::Base
  belongs_to :vocab_word
  belongs_to :user
  has_many :choices
end