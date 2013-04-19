require 'spec_helper'

describe Attempt do
  it { should belong_to(:user) }
  it { should belong_to(:vocab_word) }
  it { should have_many(:choices) }

  describe "generate" do
    #to-do
  end
end