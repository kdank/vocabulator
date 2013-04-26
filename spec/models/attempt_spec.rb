require 'spec_helper'

describe Attempt do
  it { should belong_to(:user) }
  it { should belong_to(:vocab_word) }
  it { should have_many(:choices) }

  it { should accept_nested_attributes_for(:choices) }

  describe "generate" do
    let(:attempt) {Attempt.new.generate}

    it "should have four choices" do
      expect(attempt.choices.size).to eq 4
    end

    it "should have a vocab_word" do
      expect(attempt.vocab_word).to be_an_instance_of(VocabWord)
    end

    it "should generate choices of the same type as the word" do
      attempt.choices.each do |choice|
        expect(choice.vocab_word.word_type).to eq attempt.vocab_word.word_type
      end
    end

    it "should shuffle responses" do
      pending "to-do"
    end

    it "should not include same word" do
      pending "to-do"
    end
  end
end