require 'spec_helper'

describe Choice do
  it { should belong_to(:attempt) }
  it { should belong_to(:vocab_word) }
end
