class Attempt < ActiveRecord::Base
  belongs_to :vocab_word
  belongs_to :user
  has_many :choices
  has_one :user_answer, :class_name => "VocabWord"

  accepts_nested_attributes_for :choices

  def generate
    vocab_word = VocabWord.offset(rand(VocabWord.count)).first
    self.vocab_word = vocab_word
    VocabWord.with_same_type_as(vocab_word).except(vocab_word).sample(3).each do |word|
      self.choices << Choice.new(vocab_word: word)
    end
    self.choices << Choice.new(vocab_word: vocab_word)
    self.choices.shuffle
    self
  end
end
