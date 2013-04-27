rand_vocab_word = VocabWord.offset(rand(VocabWord.count)).first

FactoryGirl.define do
  factory :attempt do
    user
    vocab_word            rand_vocab_word

    trait :with_choices do
      after :build do |attempt|
        VocabWord.with_same_type_as(vocab_word).except(vocab_word).sample(3).each do |word|
          attempt.choices << Choice.new(vocab_word: word)
        end
      end
    end
    
    trait :correct do
      user_answer  rand_vocab_word
    end

    trait :incorrect do # there is probably a better way to do this
      if rand_vocab_word = VocabWord.last
        user_answer  VocabWord.first
      else
        user_answer VocabWord.last
      end
    end 
  end
end