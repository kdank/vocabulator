require 'spec_helper'

describe Api::SpellChecksController do
  describe "show" do
    def do_get(word)
      get :show, name: word
    end

    before do
      SpellCheck.any_instance.stub(:perform).and_return({spelling: "lol"})
    end

    let(:word) { "dog" }

    it "is successful" do
      do_get(word)
      expect(response).to be_successful
    end

    it "returns json" do
      do_get(word)
      expect {
        JSON.parse response.body
      }.to_not raise_error
    end

    it "calls SpellCheck.perform" do
     	SpellCheck.any_instance.should_receive(:perform)
      do_get(word)
    end

    it 'returns results of SpellCheck.perform' do
      do_get(word)

      word_hash = JSON.parse(response.body)
      expect(word_hash['spelling']).to eq "lol"
    end
  end
end