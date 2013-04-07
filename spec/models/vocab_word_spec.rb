require 'spec_helper'

describe VocabWord do
  it { should validate_presence_of :name }
  it { should validate_presence_of :definition }
  it { should_not allow_value('ax').for(:name) }
  it { should_not allow_value('or').for(:definition) }
  it { should allow_value('axe').for(:name) }
  it { should allow_value('axe').for(:definition) }
end
