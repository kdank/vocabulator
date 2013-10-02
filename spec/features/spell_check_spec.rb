require 'spec_helper'

describe "Spell Check" do

  before do
    visit "/api/spell_checks/#{word}"
  end

  context "Word is spelled correctly" do
  	let(:word) { "dog" }
    it "returns the correct message" do
      expect(page).to have_content "Correct"
    end
  end

  context "Word is spelled incorrectly" do
  	let(:word) { "dod" }
    it "returns the incorrect message with suggestions" do
      expect(page).to have_content "Incorrect"
      expect(page).to have_content "dog"
    end
  end
end