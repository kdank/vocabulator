require 'spec_helper'

describe SpellCheck do
  let(:word) { "dog" }
  let(:spell_check) { SpellCheck.new(word) }

  describe "perform" do
    context "word is correctly spelled" do
      before do
        FFI::Aspell::Speller.any_instance.stub(:correct?).and_return(true)
      end

      it "calls correct?" do
        FFI::Aspell::Speller.any_instance.should_receive(:correct?).with(word)

        spell_check.perform
      end

      it "returns correct response" do
        correct_hash = {spelling: "#{word} is Correctly Spelled"}
        expect(spell_check.perform).to eq correct_hash
      end
    end

    context "word is incorrectly spelled" do
      before do
        FFI::Aspell::Speller.any_instance.stub(:correct?).and_return(false)
        FFI::Aspell::Speller.any_instance.stub(:suggestions).and_return(["dog", "dad"])
      end

      it "calls correct?" do
        FFI::Aspell::Speller.any_instance.should_receive(:correct?).with(word)

        spell_check.perform
      end

      it "calls suggestions" do
        FFI::Aspell::Speller.any_instance.should_receive(:suggestions).with(word)

        spell_check.perform
      end

      it "returns incorrect response" do
        incorrect_hash = {
          spelling: "#{word} is Incorrectly Spelled or does not exist",
          suggestions: ["dog", "dad"]
        }
        expect(spell_check.perform).to eq incorrect_hash
      end
    end
  end
end