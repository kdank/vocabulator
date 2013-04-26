FactoryGirl.define do
  factory :attempt do
    user
    vocab_word            VocabWord.first #fix this

    trait :with_choices do
      after :build do |attempt|
        VocabWord.with_same_type_as(vocab_word).except(vocab_word).sample(3).each do |word|
          attempt.choices << Choice.new(vocab_word: word)
        end
      end
    end
    
    trait :correct do
      user_answer  VocabWord.first #will fix this
    end
  end
end