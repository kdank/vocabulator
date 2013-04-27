class Attempt < ActiveRecord::Base
  belongs_to :vocab_word
  belongs_to :user
  belongs_to :user_answer, :class_name => "VocabWord"
  has_many :choices

  accepts_nested_attributes_for :choices

  scope :correct, where('vocab_word_id = user_answer_id') #this can be done better

  def generate
    vocab_word = VocabWord.offset(rand(VocabWord.count)).first
    self.vocab_word = vocab_word
    VocabWord.with_same_type_as(vocab_word).except(vocab_word).sample(3).each do |word|
      self.choices << Choice.new(vocab_word: word)
    end
    self.choices << Choice.new(vocab_word: vocab_word)
    self
  end
end
